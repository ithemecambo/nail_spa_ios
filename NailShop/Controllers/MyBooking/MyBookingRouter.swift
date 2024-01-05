//
//  MyBookingRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import UIKit
import Foundation

enum MyBookingSegue {
    case scheduleAlertNotification
    case reschedule(YourAppointmentModel)
}

protocol MyBookingRouter {
    func perform(_ segue: MyBookingSegue, from source: MyBookingViewController)
}

class DefaultMyBookingRouter: MyBookingRouter {
    func perform(_ segue: MyBookingSegue, from source: MyBookingViewController) {
        switch segue {
        case .reschedule(let yourData):
            let controller = RescheduleBookingViewController.instantiate()
            controller.viewModel = ResheduleBookingViewModel(appointment: yourData)
            controller.delegate = source as RescheduleBookingViewDelegate
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
        case .scheduleAlertNotification:
            let controller = ScheduleAlertViewController.instantiate()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .pageSheet
            if let sheetController = nav.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheetController.detents = [.custom(identifier: .medium, resolver: { context in
                        return 357
                    })]
                } else {
                    // Fallback on earlier versions
                    sheetController.detents = [.medium(), .large()]
                }
                sheetController.largestUndimmedDetentIdentifier = .medium
                sheetController.prefersScrollingExpandsWhenScrolledToEdge = false
                //sheetController.prefersEdgeAttachedInCompactHeight = true
                sheetController.prefersGrabberVisible = true
                //sheetController.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            source.present(nav, animated: true)
        }
    }
}

