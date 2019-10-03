//
//  UIView+border.swift
//  ReciperMVVM
//
//  Created by Евгений on 29/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

import UIKit

extension UIView {
    var borderColor: CGColor? {
        get {
            return layer.borderColor
        }
        set {
            layer.borderColor = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var layerCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
