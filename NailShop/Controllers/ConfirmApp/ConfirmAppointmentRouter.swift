//
//  ConfirmAppointmentRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/12/23.
//

import UIKit
import Foundation

enum ConfirmAppointmentSegue {
    case booking
}

protocol ConfirmAppointmentRouter {
    func perform(_ segue: ConfirmAppointmentSegue, from source: ConfirmAppointmentViewController)
}

class DefualtConfirmAppointmentRouter: ConfirmAppointmentRouter {
    func perform(_ segue: ConfirmAppointmentSegue, from source: ConfirmAppointmentViewController) {
        switch segue {
        case .booking:
            let controller = CongrateAppointmentViewController.instantiate()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            source.present(nav, animated: false)
        }
    }
}
