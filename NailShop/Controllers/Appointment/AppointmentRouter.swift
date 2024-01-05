//
//  AppointmentRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/23/23.
//

import UIKit
import Foundation

enum AppointmentSegue {
    case selectedService([PackageModel])
    case makeAppointment(String, String, UserProfielModel, StaffMemberModel, [PackageModel], [String])
}

protocol AppointmentRouter {
    func perform(_ segue: AppointmentSegue, from source: AppointmentViewController)
}

class DefaultAppointmentRouter: AppointmentRouter {
    func perform(_ segue: AppointmentSegue, from source: AppointmentViewController) {
        switch segue {
        case .selectedService(let services):
            let controller = SheetServiceViewController.instantiate()
            controller.delegate = source as SheetServiceSaveDataDelegate
            controller.viewModel = SheetServiceViewModel(services: services)
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .pageSheet
            if let sheetController = nav.sheetPresentationController {
                sheetController.detents = [.large()]
                sheetController.largestUndimmedDetentIdentifier = .large
                sheetController.prefersScrollingExpandsWhenScrolledToEdge = false
                sheetController.prefersEdgeAttachedInCompactHeight = true
                sheetController.prefersGrabberVisible = true
                sheetController.widthFollowsPreferredContentSizeWhenEdgeAttached = true
                
            }
            source.present(nav, animated: true)
        case .makeAppointment(let date, let time, let profile, let nailArt, let services, let serviceSelected):
            let controller = ConfirmAppointmentViewController.instantiate()
            controller.viewModel = ConfirmAppointmentViewModel(date: date, time: time, profile: profile, nailArt: nailArt, services: services, serviceSelected: serviceSelected)
            source.navigationController?.pushViewController(controller, animated: true)
            break
        }
    }
}

/*
 The process of make an appointment, I need to improve on
    1) check service keep select during selected service from sheet view
    2) add payment online
    3) 
 */
