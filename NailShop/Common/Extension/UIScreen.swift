//
//  UIScreen.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit

public extension UIScreen {
    static let _width = UIScreen.main.bounds.size.width
    class var width: CGFloat {
        return _width
    }
    
    static let _height = UIScreen.main.bounds.size.height
    class var height: CGFloat {
        return _height
    }
    
    static let _y = UIScreen.main.bounds.origin.y
    class var y: CGFloat {
        return _y
    }
    
    static let _x = UIScreen.main.bounds.origin.x
    class var x: CGFloat {
        return _x
    }
    
    
    static let _scale = UIScreen.main.scale
    class var scaleValue: CGFloat {
        return _scale
    }
    
    static let _size = UIScreen.main.bounds.size
    class var size: CGSize {
        return _size
    }
}


