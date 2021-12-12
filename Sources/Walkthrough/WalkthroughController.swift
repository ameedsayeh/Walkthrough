//
//  WalkthroughController.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

#if canImport(UIKit)

import UIKit

public final class WalkthroughController: NSObject {
    
    public weak var delegate: WalkthroughControllerDelegate?
    public weak var dataSource: WalkthroughControllerDataSource?
    
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
        
        self.hideCurrentPopUp()
        self.currentIndex = -1
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
        
        let overlayView = UIView(frame: UIScreen.main.bounds)

        // Overlay
        let fullPath = UIBezierPath(rect: overlayView.frame)
        fullPath.usesEvenOddFillRule = true
        
        // Component Clip path
        let punchPath = Self.buildPunchPath(for: popUp)
        self.punchPath = punchPath
        
        fullPath.append(punchPath)
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = fullPath.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = self.configurations.overlayColor.cgColor
        
        overlayView.layer.addSublayer(fillLayer)
        
        // Add Glow
        switch popUp.punchGlow {
        case .none:
            break
            
        case .glow(let glowColor, let opacity, let radius):
            let glowLayer = Self.buildGlowLayer(around: punchPath,
                                                with: glowColor,
                                                opacity: opacity,
                                                radius: radius)
            overlayView.layer.addSublayer(glowLayer)
        }

        // Add Tap recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnOverlay(_:)))
        overlayView.addGestureRecognizer(tapRecognizer)

        // Add Long Press recognizer
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.didLongPressOnOverlay(_:)))
        longPressGesture.minimumPressDuration = self.configurations.minimumLongPressDuration
        overlayView.addGestureRecognizer(longPressGesture)

        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(containerView)

        switch popUp.bodyViewPosition {
        case .above:
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: overlayView.layoutMarginsGuide.topAnchor),
                containerView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: overlayView.topAnchor, constant: punchPath.bounds.minY)
            ])

        case .below:
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: punchPath.bounds.maxY),
                containerView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: overlayView.layoutMarginsGuide.bottomAnchor)
            ])

        case .fullScreen:
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: overlayView.layoutMarginsGuide.topAnchor),
                containerView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: overlayView.layoutMarginsGuide.bottomAnchor)
            ])
        }

        // Apply user customizations
        self.delegate?.walkthroughController(self,
                                             willLayoutPopUpAt: self.currentIndex,
                                             inside: containerView,
                                             forPunchIn: punchPath.bounds,
                                             position: popUp.bodyViewPosition)

        return overlayView
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
        
        guard self.currentIndex >= 0,
              let presentationWindow = self.presentationWindow
        else { return }

        self.delegate?.walkthroughController(self, willHidePopUpAt: self.currentIndex)

        UIView.transition(with: presentationWindow,
                          duration: self.configurations.animationDuration,
                          options: self.configurations.animationTypes) { [weak self] in

            self?.popUpView?.removeFromSuperview()

        } completion: { [weak self, currentIndex] _ in

            guard let self = self else { return }
            self.delegate?.walkthroughController(self, didHidePopUpAt: currentIndex)
        }
    }
    
    // MARK: Actions
    
    @objc private func didTapOnOverlay(_ recognizer: UITapGestureRecognizer) {
        
        let tapPoint = recognizer.location(in: self.popUpView)
        
        if self.punchPath?.bounds.contains(tapPoint) ?? false {
            self.delegate?.walkthroughController(self, didTapInsidePunchForPopUpAt: self.currentIndex)
        }
        
        self.handleNextPopUp()
    }

    @objc private func didLongPressOnOverlay(_ recognizer: UILongPressGestureRecognizer) {

        let pressPoint = recognizer.location(in: self.popUpView)

        guard self.punchPath?.bounds.contains(pressPoint) ?? false else { return }

        self.delegate?.walkthroughController(self, didLongPressInsidePunchForPopUpAt: self.currentIndex)
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
            
            switch popUp.cornerRounding {
            case .none:
                return UIBezierPath(rect: punchRect)
                
            case .unified(let radius):
                return UIBezierPath(roundedRect: punchRect, cornerRadius: radius)
                
            case .custom(let topLeft, let topRight, let bottomLeft, let bottomRight):
                return UIBezierPath(shouldRoundRect: punchRect,
                                    topLeftRadius: CGSize(width: topLeft, height: topLeft),
                                    topRightRadius: CGSize(width: topRight, height: topRight),
                                    bottomLeftRadius: CGSize(width: bottomLeft, height: bottomLeft),
                                    bottomRightRadius: CGSize(width: bottomRight, height: bottomRight))
            }
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
