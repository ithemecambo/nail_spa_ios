//
//  SettingsViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/14/23.
//

import UIKit
import Foundation

class SettingsViewModel {
    
    func showLogOutPopup(parent: UIViewController, logout: @escaping (() -> ())) {
        let actionSheet = UIAlertController(title: nil,
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Log Out", style: .default) { (alert) in
            logout()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(logoutAction)
        actionSheet.addAction(cancelAction)
        parent.present(actionSheet, animated: true, completion: nil)
    }
}
