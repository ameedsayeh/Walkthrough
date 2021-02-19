//
//  WalkthroughPopup.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

class WalkthroughPopup {
    
    weak var targetComponent: UIView?
    var arrowView: UIView?
    var bodyView: UIView?
    var customPunch: UIBezierPath?
    var arrowHookCorner: HookCorner = .top
    var isRounded: Bool
    
    internal init(targetComponent: UIView? = nil, arrowView: UIView? = nil, bodyView: UIView? = nil, customPunch: UIBezierPath? = nil, arrowHookCorner: WalkthroughPopup.HookCorner = .top, isRounded: Bool) {
        self.targetComponent = targetComponent
        self.arrowView = arrowView
        self.bodyView = bodyView
        self.customPunch = customPunch
        self.arrowHookCorner = arrowHookCorner
        self.isRounded = isRounded
    }
    
    enum HookCorner {
        
        case top
        case left
        case right
        case bottom
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
}
