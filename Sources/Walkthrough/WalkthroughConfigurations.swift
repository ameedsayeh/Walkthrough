//
//  WalkthroughConfigurations.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

#if canImport(UIKit)

import UIKit

public struct WalkthroughConfigurations {
    
    var overlayColor: UIColor = UIColor.black.withAlphaComponent(0.5)
    var animationDuration: TimeInterval = 0.3
    var animationTypes: UIView.AnimationOptions = [.transitionCrossDissolve]
    var minimumLongPressDuration: TimeInterval = 0.1
    
    public init(overlayColor: UIColor = UIColor.black.withAlphaComponent(0.5),
                animationDuration: TimeInterval = 0.3,
                animationTypes: UIView.AnimationOptions = [.transitionCrossDissolve],
                minimumLongPressDuration: TimeInterval = 0.1) {
        
        self.overlayColor = overlayColor
        self.animationDuration = animationDuration
        self.animationTypes = animationTypes
        self.minimumLongPressDuration = minimumLongPressDuration
    }
}

#endif
