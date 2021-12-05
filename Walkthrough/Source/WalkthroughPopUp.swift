//
//  WalkthroughPopUp.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

class WalkthroughPopUp {
    
    weak var targetComponent: UIView?
    var arrowView: UIView?
    var bodyView: UIView?
    var customPunch: UIBezierPath?
    var cornerRounding: Rounding = .none
    var bodyViewPosition: BodyViewPosition = .above
    var punchPadding: CGFloat = 4
    
    internal init(targetComponent: UIView? = nil,
                  arrowView: UIView? = nil,
                  bodyView: UIView? = nil,
                  bodyViewPosition: BodyViewPosition = .fullScreen,
                  customPunch: UIBezierPath? = nil,
                  cornerRounding: Rounding = .none,
                  punchPadding: CGFloat = 4) {
        
        self.targetComponent = targetComponent
        self.arrowView = arrowView
        self.bodyView = bodyView
        self.bodyViewPosition = bodyViewPosition
        self.customPunch = customPunch
        self.cornerRounding = cornerRounding
        self.punchPadding = punchPadding
    }
}

// MARK: Rounding
extension WalkthroughPopUp {

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

extension WalkthroughPopUp {

    enum BodyViewPosition {

        case above
        case below
        case fullScreen
    }
}
