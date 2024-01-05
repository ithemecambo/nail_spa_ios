//
//  SettingsRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/28/23.
//

import UIKit
import Foundation

enum SettingsSegue {
    case language
    case option
    case logout
    case feedback
}

protocol SettingsRouter {
    func perform(_ segue: SettingsSegue, from source: SettingsViewController)
}

class DefaultSettingsRouter: SettingsRouter {
    func perform(_ segue: SettingsSegue, from source: SettingsViewController) {
        switch segue {
        case .language: break
        case .option: break
        case .logout:
            let scene = UIApplication.shared.connectedScenes.first
            if let appDelegate = scene?.delegate as? SceneDelegate {
                Launcher.launchLogin(with: appDelegate.window)
            }
        case .feedback:
            let configuration = FeedbackConfiguration(toRecipients: ["senghort.rupp@gmail.com"], usesHTML: true)
            let controller    = FeedbackViewController(configuration: configuration)
            source.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

