//
//  UIView+Extension.swift
//  Walkthrough
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

extension UIView {
    
    var globalPoint: CGPoint {
        self.superview?.convert(self.frame.origin, to: nil) ?? self.frame.origin
    }
}
