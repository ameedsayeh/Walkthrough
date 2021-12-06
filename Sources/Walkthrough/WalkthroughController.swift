//
//  WalkthroughController.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

#if canImport(UIKit)

import UIKit

public final class WalkthroughController {
    
    weak var delegate: WalkthroughControllerDelegate?
    weak var dataSource: WalkthroughControllerDataSource?
    
    private(set) var configurations: WalkthroughConfigurations

    private weak var presentationWindow: UIWindow?

    private var currentIndex: Int = -1
    private var popUpView: UIView?
    private var punchPath: UIBezierPath?
    
    public init(with configurations: WalkthroughConfigurations = WalkthroughConfigurations()) {
        self.configurations = configurations
    }

    // MARK: Start Mechanism

    public func start(on window: UIWindow) {

        self.presentationWindow = window
        self.currentIndex == -1 ?
            self.start():
            self.startOver()
    }

    private func start() {

        guard let dataSource = self.dataSource else { return }

        let numberOfPopUps = dataSource.numberOfWalkthroughPopups(for: self)

        guard numberOfPopUps > 0 else { return }

        self.currentIndex = 0
        self.handlePopUp(at: self.currentIndex)
    }

    private func startOver() {

        self.stop()
        self.start()
    }

    // MARK: Stop Mechanism

    public func forceStop() {
        self.stop(force: true)
    }

    private func stop(force: Bool = false) {

        guard self.currentIndex >= 0 else { return }

        self.currentIndex = -1
        self.hideCurrentPopUp()
        self.delegate?.walkthroughControllerDidFinishFlow(self, forceStop: force)
    }

    // MARK: Show Mechanism

    private func handleNextPopUp() {

        self.hideCurrentPopUp()
        self.currentIndex += 1
        self.handlePopUp(at: self.currentIndex)
    }

    private func handlePopUp(at index: Int) {

        guard let dataSource = self.dataSource,
              index < dataSource.numberOfWalkthroughPopups(for: self),
              let popUp = dataSource.walkthroughPopUp(for: self, at: index)
        else {

            self.stop()
            return
        }

        if self.delegate?.walkthroughController(self, shouldShowPopUpAt: index) ?? true {
            self.showPopUp(popUp, at: index)
        } else {
            self.handleNextPopUp()
        }
    }

    private func showPopUp(_ popup: WalkthroughPopUp, at index: Int) {

        self.delegate?.walkthroughController(self, willShowPopUpAt: index)
        self.buildAndPresentPopUp(for: popup)
        self.delegate?.walkthroughController(self, didShowPopUpAt: index)
    }

    private func buildAndPresentPopUp(for popUp: WalkthroughPopUp) {

        let popUpView = self.buildPopUp(for: popUp)
        self.popUpView = popUpView
        self.presentPopUp(popUpView)
    }

    private func buildPopUp(for popUp: WalkthroughPopUp) -> UIView {

        let containerView = UIView(frame: UIScreen.main.bounds)

        // Overlay
        let fullPath = UIBezierPath(rect: containerView.frame)
        fullPath.usesEvenOddFillRule = true

        // Component Clip path
        let punchPath = Self.buildPunchPath(for: popUp)
        self.punchPath = punchPath

        fullPath.append(punchPath)

        let fillLayer = CAShapeLayer()
        fillLayer.path = fullPath.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = self.configurations.overlayColor.cgColor

        containerView.layer.addSublayer(fillLayer)

        // Add Glow
        switch popUp.punchGlow {
        case .none:
            break

        case .glow(let glowColor, let opacity, let radius):
            let glowLayer = Self.buildGlowLayer(around: punchPath,
                                                with: glowColor,
                                                opacity: opacity,
                                                radius: radius)
            containerView.layer.addSublayer(glowLayer)
        }

        // Add body view
        if let bodyView = popUp.bodyView {

            containerView.addSubview(bodyView)

            switch popUp.bodyViewPosition {
            case .above:
                bodyView.frame.origin.y = punchPath.bounds.minY - bodyView.bounds.height
                bodyView.center.x = punchPath.bounds.midX

            case .below:
                bodyView.frame.origin.y = punchPath.bounds.maxY
                bodyView.center.x = punchPath.bounds.midX

            case .fullScreen:
                break
            }
        }

        // Add Tap recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnOverlay(_:)))
        containerView.addGestureRecognizer(tapRecognizer)

        return containerView
    }

    private func presentPopUp(_ popUpView: UIView) {

        guard let presentationWindow = presentationWindow else { return }

        UIView.transition(with: presentationWindow,
                          duration: self.configurations.animationDuration,
                          options: self.configurations.animationTypes) {
            presentationWindow.addSubview(popUpView)
        }
    }

    // MARK: Hide Mechanism

    private func hideCurrentPopUp() {

        guard self.currentIndex >= 0 else { return }

        self.delegate?.walkthroughController(self, willHidePopUpAt: self.currentIndex)
        self.popUpView?.removeFromSuperview()
        self.delegate?.walkthroughController(self, didHidePopUpAt: self.currentIndex)
    }

    // MARK: Actions

    @objc private func didTapOnOverlay(_ recognizer: UITapGestureRecognizer) {

        let tapPoint = recognizer.location(in: self.popUpView)

        if self.punchPath?.bounds.contains(tapPoint) ?? false {
            self.delegate?.walkthroughController(self, didTapInsidePunchForPopUpAt: self.currentIndex)
        }

        self.handleNextPopUp()
    }

    // Helpers
    private class func buildPunchPath(for popUp: WalkthroughPopUp) -> UIBezierPath {

        // Custom Punch
        if let customPunch = popUp.customPunch {
            return customPunch
        }

        // Default Punch for target view
        if let targetView = popUp.targetComponent {

            let origin = targetView.globalPoint
            let size = targetView.frame.size

            let punchRect = CGRect(x: origin.x - popUp.punchPadding,
                                   y: origin.y - popUp.punchPadding,
                                   width: size.width + popUp.punchPadding.doubled,
                                   height: size.height + popUp.punchPadding.doubled)

            return UIBezierPath(roundedRect: punchRect, cornerRadius: popUp.cornerRounding.cornerRadius)
        }

        // No Punch
        return .init(rect: .zero)
    }

    private class func buildGlowLayer(around path: UIBezierPath,
                                      with color: UIColor,
                                      opacity: Float,
                                      radius: CGFloat) -> CAShapeLayer {

        let glowLayer = CAShapeLayer()
        glowLayer.shadowPath = path.cgPath
        glowLayer.shadowColor = color.cgColor
        glowLayer.shadowOpacity = opacity
        glowLayer.shadowRadius = radius
        glowLayer.fillRule = .evenOdd

        let clipFrame = path.bounds.insetBy(dx: -radius.doubled,
                                                 dy: -radius.doubled)

        let translation = CGAffineTransform(translationX: -path.bounds.origin.x + radius.doubled,
                                            y: -path.bounds.origin.y + radius.doubled)

        let clipPath = CGMutablePath()

        clipPath.addRect(CGRect(origin: .zero, size: clipFrame.size))
        clipPath.addPath(path.cgPath, transform: translation)
        clipPath.closeSubpath()

        let maskLayer = CAShapeLayer()
        maskLayer.frame = clipFrame
        maskLayer.fillRule = .evenOdd
        maskLayer.path = clipPath

        glowLayer.mask = maskLayer;

        return glowLayer
    }
}

#endif
