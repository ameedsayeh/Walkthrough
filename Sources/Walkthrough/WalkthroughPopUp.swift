//
//  WalkthroughPopUp.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

#if canImport(UIKit)

import UIKit

public class WalkthroughPopUp {
    
    weak var targetComponent: UIView?
    var arrowView: UIView?
    var bodyView: UIView?
    var customPunch: UIBezierPath?
    var cornerRounding: Rounding = .none
    var bodyViewPosition: BodyViewPosition = .above
    var punchPadding: CGFloat = .zero
    var punchGlow: PunchGlow = .none
    
    public init(targetComponent: UIView? = nil,
                  arrowView: UIView? = nil,
                  bodyView: UIView? = nil,
                  bodyViewPosition: BodyViewPosition = .fullScreen,
                  customPunch: UIBezierPath? = nil,
                  cornerRounding: Rounding = .none,
                  punchPadding: CGFloat = .zero,
                  punchGlow: PunchGlow = .none) {
        
        self.targetComponent = targetComponent
        self.arrowView = arrowView
        self.bodyView = bodyView
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
