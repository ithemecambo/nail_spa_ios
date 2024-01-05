//
//  ChangePasswordFormRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/14/23.
//

import Foundation

enum ChangePasswordFormSegue {
    case done
}

protocol ChangePasswordFormRouter {
    func perform(_ segue: ChangePasswordFormSegue, from source: ChangePasswordFormViewController)
}

class DefaultChangePasswordFormRouter: ChangePasswordFormRouter {
    func perform(_ segue: ChangePasswordFormSegue, from source: ChangePasswordFormViewController) {
        switch segue {
        case .done:
            source.navigationController?.popToRootViewController(animated: true)
        }
    }
}
