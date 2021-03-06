//
//  WalkthroughConfigurations.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

struct WalkthroughConfigurations {
    
    var overlayColor: UIColor = UIColor.black.withAlphaComponent(0.5)
    var forwardTouchEvents: Bool = false
    var animationDuration: TimeInterval = 0.2
    var animationTypes: UIView.AnimationOptions = [.transitionCrossDissolve]
}
