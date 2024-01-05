//
//  SignInRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/28/23.
//

import UIKit
import Foundation

enum SignInSegue {
    case createAccount
    case login
}

protocol SignInRouter {
    func perform(_ segue: SignInSegue, from source: SignInViewController)
}

class DefaultSignInRouter: SignInRouter  {
    func perform(_ segue: SignInSegue, from source: SignInViewController) {
        switch segue {
        case .createAccount:
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate = scene?.delegate as? SceneDelegate {
                Launcher.launchMain(with: sceneDelegate.window)
            }
        case .login:
            break
        }
    }
}
