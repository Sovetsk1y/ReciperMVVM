//
//  String+toAttributed.swift
//  ReciperMVVM
//
//  Created by Евгений on 29/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

import UIKit

extension String {
    
    func toAttributed(alignment: NSTextAlignment?, color: UIColor?, font: UIFont?) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let alignment = alignment {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = alignment
            attributes[.paragraphStyle] = paragraphStyle
        }
        if let color = color {
            attributes[.foregroundColor] = color
        }
        if let font = font {
            attributes[.font] = font
        }
        return toAttributed(attributes: attributes)
    }
    
    fileprivate func toAttributed(attributes: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
}
