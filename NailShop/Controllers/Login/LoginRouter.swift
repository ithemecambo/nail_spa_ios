//
//  LoginRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/28/23.
//

import UIKit
import Foundation

enum LoginSegue {
    case login
    case signUp
    case forgetPassword(String)
    case facebook
    case google(SocialLoginModel)
}

protocol LoginRouter {
    func perform(_ segue: LoginSegue, from source: LoginViewController)
}

class DefaultLoginRouter: LoginRouter {
    func perform(_ segue: LoginSegue, from source: LoginViewController) {
        switch segue {
        case .login:
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate = scene?.delegate as? SceneDelegate {
                Launcher.launchMain(with: sceneDelegate.window)
            }
            
        case .signUp:
            let controller = SignInViewController.instatiate()
            let nav = UINavigationController(rootViewController: controller)
            if let navigation = nav.topViewController {
                source.navigationController?.pushViewController(navigation, animated: true)
            }
            
        case .forgetPassword(let type):
            let controller = ChangePasswordViewController.instantiate()
            controller.viewModel = ChangePasswordViewModel(sourceType: type)
            let nav = UINavigationController(rootViewController: controller)
            if let navigation = nav.topViewController {
                source.navigationController?.pushViewController(navigation, animated: true)
            }
            
        case .facebook:
            break
        case .google(let socialUser):
            let controller = CreatePasswordViewController.instantiate()
            controller.viewModel = CreatePasswordViewModel(socialUser: socialUser)
            let nav = UINavigationController(rootViewController: controller)
            if let navigator = nav.topViewController {
                source.navigationController?.pushViewController(navigator, animated: true)
            }
        }
    }
}

