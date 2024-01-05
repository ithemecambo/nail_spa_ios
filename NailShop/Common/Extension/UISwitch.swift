//
//  UISwitch.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import UIKit
import Foundation

extension UISwitch {

    static let standardHeight: CGFloat = 31
    static let standardWidth: CGFloat = 51
    
    @IBInspectable var width: CGFloat {
        set {
            set(width: newValue, height: height)
        }
        get {
            frame.width
        }
    }
    
    @IBInspectable var height: CGFloat {
        set {
            set(width: width, height: newValue)
        }
        get {
            frame.height
        }
    }
    
    func set(width: CGFloat, height: CGFloat) {

        let heightRatio = height / UISwitch.standardHeight
        let widthRatio = width / UISwitch.standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
