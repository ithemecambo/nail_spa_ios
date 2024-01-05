//
//  ForgetPasswordRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/14/23.
//

import UIKit
import Foundation

enum ForgetPasswordSegue {
    case done
}

protocol ForgetPasswordRouter {
    func perform(_ segue: ForgetPasswordSegue, from source: ForgetPasswordViewController)
}

class DefaultForgetPasswordRouter: ForgetPasswordRouter {
    func perform(_ segue: ForgetPasswordSegue, from source: ForgetPasswordViewController) {
        switch segue {
        case .done:
            let scene = UIApplication.shared.connectedScenes.first
            if let delegate = scene?.delegate as? SceneDelegate {
                Launcher.launchLogin(with: delegate.window)
            }
        }
    }
}
