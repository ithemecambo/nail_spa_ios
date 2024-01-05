//
//  UpdateInfoRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/23/23.
//

import Foundation

enum UpdateInfoSegue {
    case editInfo(UserProfielModel)
}

protocol UpdateInfoRouter {
    func perform(_ segue: UpdateInfoSegue, from source: UpdateInfoViewController)
}

class DefaultUpdateInfoRouter: UpdateInfoRouter {
    func perform(_ segue: UpdateInfoSegue, from source: UpdateInfoViewController) {
        switch segue {
        case .editInfo(let profile):
            let controller = UpdateInfoFormViewController.instantiate()
            controller.viewModel = UpdateInfoFormViewModel(profile: profile)
            source.navigationController?.pushViewController(controller, animated: false)
        }
    }
}
