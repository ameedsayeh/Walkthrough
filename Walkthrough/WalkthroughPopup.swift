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
    var cornerRounding: Rounding = .none
    var punchPadding: CGFloat = 4
    
    internal init(targetComponent: UIView? = nil, arrowView: UIView? = nil, bodyView: UIView? = nil, customPunch: UIBezierPath? = nil, arrowHookCorner: WalkthroughPopup.HookCorner = .top, cornerRounding: WalkthroughPopup.Rounding = .none, punchPadding: CGFloat = 4) {
        
        self.targetComponent = targetComponent
        self.arrowView = arrowView
        self.bodyView = bodyView
        self.customPunch = customPunch
        self.arrowHookCorner = arrowHookCorner
        self.cornerRounding = cornerRounding
        self.punchPadding = punchPadding
    }

    enum HookCorner {
        
        case top
        case left
        case right
        case bottom
    }
    
    enum Rounding {
        
        case none
        case custom(CGFloat)
        case fullyRounded
        
        var cornerRadius: CGFloat {
            
            switch self {
            
            case .none:
                return 0
            case .custom(let customValue):
                return customValue
            case .fullyRounded:
                return .infinity
            }
        }
    }
}
