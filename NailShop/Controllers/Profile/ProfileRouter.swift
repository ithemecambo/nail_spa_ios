//
//  ProfileRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit
import StoreKit
import Foundation

enum ProfileSegue {
    case ourService(String)
    case updateInformation
    case changePassword(String)
    case contactUs
    case aboutUs
    case termCondition
    case darkMode
    case shareApp
    case ratingApp
    case setting
}

protocol ProfileRouter {
    func perform(_ segue: ProfileSegue, from source: ProfileViewController)
}

class DefaultProfileRouter: ProfileRouter {
    func perform(_ segue: ProfileSegue, from source: ProfileViewController) {
        switch segue {
        case .ourService(let data):
            let controller = OurServiceViewController.instantiate()
            controller.viewModel = OurServiceViewModel(source: data)
            source.show(controller, sender: self)
        case .updateInformation:
            let controller = UpdateInfoViewController.instantiate()
            source.show(controller, sender: self)
        case .changePassword(let type):
            let controller = ChangePasswordViewController.instantiate()
            controller.viewModel = ChangePasswordViewModel(sourceType: type)
            source.show(controller, sender: self)
        case .contactUs:
            let controller = ContactUsViewController.instantiate()
            source.show(controller, sender: self)
        case .aboutUs:
            let controller = AboutUsViewController.instantiate()
            source.show(controller, sender: self)
        case .termCondition:
            let controller = TermConditionViewController.instantiate()
            source.show(controller, sender: self)
        case .darkMode:
            let controller = DarkModeViewController.instantiate()
            source.show(controller, sender: self)
        case .shareApp:
            let stringWithLink = "Please download this app here in App Store: https://google.com"
            let activityController = UIActivityViewController(activityItems: [stringWithLink], applicationActivities: nil)
            activityController.completionWithItemsHandler = { (nil, completed, _, error) in
                if completed {
                    consoleLog("completed")
                } else {
                    consoleLog("cancled")
                }
            }
            if let popoverController = activityController.popoverPresentationController {
                popoverController.sourceView = source.view
                popoverController.sourceRect = CGRect(x: UIScreen._width / 3, y: UIScreen._width / 2, width: 300, height: 350)
                popoverController.permittedArrowDirections = [.up, .down]
            }
            source.present(activityController, animated: true) {
                consoleLog("presented")
            }

        case .ratingApp:
            guard let scene = UIApplication.shared.foregroundActiveScene else { return }
            SKStoreReviewController.requestReview(in: scene)
            
        case .setting:
            let controller = SettingsViewController.instantiate()
            source.show(controller, sender: self)
        }
    }
}
