//
//  UIApplication.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit
import StoreKit
import Foundation

extension UIApplication {
    var foregroundActiveScene: UIWindowScene? {
        connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
}
