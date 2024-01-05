//
//  CongrateAppointmentRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/13/23.
//

import UIKit
import Foundation

enum CongrateAppointmentSegue {
    case goMain
}

protocol CongrateAppointmentRouter {
    func perform(_ segue: CongrateAppointmentSegue, from source: CongrateAppointmentViewController)
}

class DefaultCongrateAppointmentRouter: CongrateAppointmentRouter {
    func perform(_ segue: CongrateAppointmentSegue, from source: CongrateAppointmentViewController) {
        switch segue {
        case .goMain:
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate = scene?.delegate as? SceneDelegate {
                Launcher.launchMain(with: sceneDelegate.window)
            }
        }
    }
}
