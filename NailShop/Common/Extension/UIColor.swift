//
//  UIColor.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import Foundation
import UIKit

extension UIColor {
    
    static let colorApp         = UIColor(rgb: 0x4DAF50) // 50A265
    static let colorTitle       = UIColor(rgb: 0x3C3C3B)
    static let colorGray        = UIColor(rgb: 0xE8E7E7)
    static let colorWhite       = UIColor(rgb: 0xFFFFFF)
    static let colorBackground  = UIColor(named: "backgroundColor")

    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
    
    convenience init(rgb: Int, alpha: CGFloat) {
        let r = CGFloat((rgb & 0xFF0000) >> 16)/255
        let g = CGFloat((rgb & 0xFF00) >> 8)/255
        let b = CGFloat(rgb & 0xFF)/255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(rgb: Int) {
        self.init(rgb:rgb, alpha:1.0)
    }
    
    convenience init(hex: String) {
        var hexUpdate = hex
        if (hexUpdate.hasPrefix("#")) {
            hexUpdate.remove(at: hexUpdate.startIndex)
        }
        
        let scanner = Scanner(string: hexUpdate)
        //scanner.scanLocation = 0
        scanner.currentIndex = hexUpdate.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    var hexString:String? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
}
