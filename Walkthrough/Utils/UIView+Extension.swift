//
//  UIView+Extension.swift
//  App Tour
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

extension UIView {
    
    var globalPoint: CGPoint {
        return self.superview?.convert(self.frame.origin, to: nil) ?? self.frame.origin
    }
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    
    //
    //    static func referencePoint(child childView: UIView, ancestor ancestorView: UIView) -> CGPoint {
    //
    //        return .zero
    //    }
    
}
