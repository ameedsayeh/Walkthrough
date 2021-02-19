//
//  WalkthroughController.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

final class WalkthroughController {
    
    weak var delegate: WalkthroughControllerDelegate?
    weak var dataSource: WalkthroughControllerDataSource?
    
    private(set) var configurations: WalkthroughConfigurations
    
    private weak var presentationWindow: UIWindow?
    
    private var hasStarted = false
    private var currentIndex: Int = 0
    private var isSkipped = false
    
    private var overlayView: UIView?
    
    init() {
        self.configurations = WalkthroughConfigurations()
    }
    
    init(with configurations: WalkthroughConfigurations) {
        self.configurations = configurations
    }
    
    public func start(on window: UIWindow) {
        
        if !hasStarted {
            self.presentationWindow = window
            self.start()
        }
    }
    
    public func stop() {
        
        self.hasStarted = false
        self.currentIndex = 0
        self.delegate?.didFinishWalkthrough(for: self, skipped: self.isSkipped)
    }
    
    private func start() {
        
        self.hasStarted = true
        self.showPopup(at: 0)
    }
    
    private func showPopup(at index: Int) {
        
        guard
            let dataSource = self.dataSource,
            index < dataSource.numberOfWalkthroughPopups(for: self)
        else {
            
            self.stop()
            return
        }
        
        let popUp = dataSource.walkthroughPopup(for: self, at: index)
        
        if self.delegate?.walkthroughController(for: self, shouldShow: popUp, at: index) ?? true {
            self.presentPopup(popUp, at: index)
        } else {
            currentIndex += 1
            self.showPopup(at: currentIndex)
        }
    }
    
    private func presentPopup(_ popup: WalkthroughPopup, at index: Int) {
        
        self.delegate?.walkthroughController(for: self, willShow: popup, at: index)
        
        let containerView = UIView(frame: UIScreen.main.bounds)
        let fullPath = UIBezierPath(rect: containerView.frame)
        
        let punchPath: UIBezierPath
        
        if let customPunch = popup.customPunch {
            
            punchPath = customPunch
            
        } else if let targetView = popup.targetComponent {
            
            let origin = targetView.globalPoint
            let size = targetView.frame.size
            
            let punchRect = CGRect(x: origin.x - popup.punchPadding,
                                   y: origin.y - popup.punchPadding,
                                   width: size.width + popup.punchPadding.doubleValue,
                                   height: size.height + popup.punchPadding.doubleValue)
            
            punchPath = UIBezierPath(roundedRect: punchRect, cornerRadius: popup.cornerRounding.cornerRadius)
            
        } else {
            
            punchPath = UIBezierPath()
        }
        
        fullPath.append(punchPath)
        
        fullPath.usesEvenOddFillRule = true
        let fillLayer = CAShapeLayer()
        fillLayer.path = fullPath.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = self.configurations.overlayColor.cgColor
        
        containerView.layer.addSublayer(fillLayer)
        containerView.isUserInteractionEnabled = !self.configurations.forwardTouchEvents
        
        self.presentationWindow?.addSubview(containerView)
        self.overlayView = containerView
    }
}
