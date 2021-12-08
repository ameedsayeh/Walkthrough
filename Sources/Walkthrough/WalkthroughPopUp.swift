//
//  WalkthroughPopUp.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

#if canImport(UIKit)

import UIKit

public class WalkthroughPopUp {
    
    weak var targetComponent: UIView?
    var bodyViewPosition: BodyViewPosition = .below
    var customPunch: UIBezierPath?
    var cornerRounding: Rounding = .none
    var punchPadding: CGFloat = .zero
    var punchGlow: PunchGlow = .none
    
    public init(targetComponent: UIView? = nil,
                bodyViewPosition: BodyViewPosition = .below,
                customPunch: UIBezierPath? = nil,
                cornerRounding: Rounding = .none,
                punchPadding: CGFloat = .zero,
                punchGlow: PunchGlow = .none) {
        
        self.targetComponent = targetComponent
        self.bodyViewPosition = bodyViewPosition
        self.customPunch = customPunch
        self.cornerRounding = cornerRounding
        self.punchPadding = punchPadding
        self.punchGlow = punchGlow
    }
}

// MARK: Rounding
public extension WalkthroughPopUp {
    
    enum Rounding {
        
        case none
        case unified(radius: CGFloat)
        case custom(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat)
    }
}

// MARK: BodyViewPosition
public extension WalkthroughPopUp {
    
    enum BodyViewPosition {
        
        case above
        case below
        case fullScreen
    }
}

// MARK: Punch Glow
public extension WalkthroughPopUp {
    
    enum PunchGlow {

        case none
        case glow(color: UIColor, opacity: Float, radius: CGFloat)
    }
}

#endif
