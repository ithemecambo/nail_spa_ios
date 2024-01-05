//
//  UINavigationController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit
import Foundation

extension UINavigationController {
    
    var setupBackButton: () {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .systemGreen
    }
}
