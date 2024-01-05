//
//  SendEmailChangePasswordRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/14/23.
//

import UIKit
import Foundation

enum SendEmailSegue {
    case changePassword(UserModel)
    case resetPassword(UserModel)
}

protocol SendEmailChangePasswordRouter {
    func perform(_ segue: SendEmailSegue, from source: ChangePasswordViewController)
}

class DefaultSendEmailChangePasswordRouter: SendEmailChangePasswordRouter {
    func perform(_ segue: SendEmailSegue, from source: ChangePasswordViewController) {
        switch segue {
        case .changePassword(let userData):
            let controller = ChangePasswordFormViewController.instantiate()
            controller.viewModel = ChangePasswordFormViewModel(user: userData)
            source.navigationController?.pushViewController(controller, animated: true)
            
        case .resetPassword(let userData):
            let controller = ForgetPasswordViewController.instantiate()
            controller.viewModel = ForgetPasswordViewModel(user: userData)
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            source.present(nav, animated: true)
        }
    }
}
