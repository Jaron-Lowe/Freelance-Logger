//
//  UIView+Inspectable.swift
//
//  Created by Jaron Lowe.
//  Copyright © 2011-Present Jaron Lowe. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {return layer.borderWidth;}
        set{layer.borderWidth = newValue}
    }
    
    @IBInspectable var borderColor: UIColor? {
        
        get {
            if (layer.borderColor == nil) {return nil;}
            else {return UIColor(CGColor: layer.borderColor!);}
        }
        set{layer.borderColor = newValue?.CGColor;}
    }
}