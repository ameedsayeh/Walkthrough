//
//  UIView+Extension.swift
//  App Tour
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

extension UIView {
    
    var globalPoint: CGPoint {
        self.superview?.convert(self.frame.origin, to: nil) ?? self.frame.origin
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
}
