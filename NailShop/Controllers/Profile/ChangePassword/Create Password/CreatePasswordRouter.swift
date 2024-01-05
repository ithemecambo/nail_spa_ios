//
//  CreatePasswordRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/28/23.
//

import UIKit

enum CreatePasswordSegue {
    case main
}

protocol CreatePasswordRouter {
    func perform(_ segue: CreatePasswordSegue, from source: CreatePasswordViewController)
}

class DefaultCreatePasswordRouter: CreatePasswordRouter {
    func perform(_ segue: CreatePasswordSegue, from source: CreatePasswordViewController) {
        switch segue {
        case .main:
            let scene = UIApplication.shared.connectedScenes.first
            if let appDelegate = scene?.delegate as? SceneDelegate {
                Launcher.launchMain(with: appDelegate.window)
            }
        }
    }
}

