//
//  HomeRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/21/23.
//

import UIKit
import Foundation

enum HomeSegue {
    case promotion
    case nailArt
    case booking
    case service(String)
    case notification
    case main
}

protocol HomeRouter {
    func perform(_ segue: HomeSegue, from source: HomeViewController)
}

class DefaultHomeRouter: HomeRouter {
    func perform(_ segue: HomeSegue, from source: HomeViewController) {
        switch segue {
        case .promotion:
            break
        case .nailArt:
            break
        case .booking:
            let scene = UIApplication.shared.connectedScenes.first
            if let appDelegate = scene?.delegate as? SceneDelegate {
                let controller = MyTabViewController.instantiate()
                controller.selectedIndex = 1
                appDelegate.window?.rootViewController = controller
                appDelegate.window?.makeKeyAndVisible()
            }
        case .service(let data):
            let controller = OurServiceViewController.instantiate()
            controller.viewModel = OurServiceViewModel(source: data)
            source.navigationController?.pushViewController(controller, animated: true)
            
        case .notification:
            let vc = NotificationViewController.instantiate()
            source.navigationController?.pushViewController(vc, animated: true)
            
        case .main:
            let scene = UIApplication.shared.connectedScenes.first
            if let appDelegate = scene?.delegate as? SceneDelegate {
                Launcher.launchLogin(with: appDelegate.window)
            }
        }
    }
}
