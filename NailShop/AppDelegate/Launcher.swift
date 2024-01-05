//
//  LaunchApp.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/10/23.
//

import UIKit
import Foundation

class Launcher {
    
    static func launchMain(with window: UIWindow?) {
        let controller = MyTabViewController.instantiate()
        window?.rootViewController = controller
        CoreDataManager.shared.delete()
        window?.makeKeyAndVisible()
    }
    
    static func launchLogin(with window: UIWindow?) {
        let controller = LoginViewController.instantiate()
        let nav = UINavigationController(rootViewController: controller)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}
