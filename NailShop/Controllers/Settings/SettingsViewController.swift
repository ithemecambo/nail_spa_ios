//
//  SettingsViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/5/23.
//

import UIKit
import Kingfisher
import GoogleSignIn

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: SettingsTableView! {
        didSet {
            self.tableView._delegate    = self
            self.tableView._dataSource  = self
        }
    }
    
    private var viewModel = SettingsViewModel()
    private var router = DefaultSettingsRouter()
    private var settings: [AppSettingSectionModel] = AppSettingSectionModel.appSettings
    
    static func instantiate() -> SettingsViewController {
        let controller = Setting.instantiateViewController(withIdentifier: String(describing: self)) as! SettingsViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
}

extension SettingsViewController {
    private func loadItems() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            settings[3].items![1].value = "V " + version
        }
        KingfisherManager.shared.cache.calculateDiskStorageSize { (cacheSize) in
//            let size = Double(cacheSize/1024)/1024
//            if floor(size) == size {
//                self.items[3][0].value = "\(Int(size)) MB"
//            } else {
//                self.items[3][0].value = (NSString(format:  "%.2f", size) as String) + " MB"
//            }
        }
        self.tableView.reloadData()
    }
}

extension SettingsViewController: SettingsTableViewDataSource {
    func settingItemLists() -> [AppSettingSectionModel] {
        return settings
    }
}

extension SettingsViewController: SettingsTableViewDelegate {
    func didSelect(indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            consoleLog("\(indexPath.section), \(indexPath.row)")
        case 1:
            consoleLog("\(indexPath.section), \(indexPath.row)")
        case 2:
            switch indexPath.row {
            case 0:
                self.router.perform(.feedback, from: self)
            case 1:
                consoleLog("row: \(indexPath.row)")
            case 2:
                consoleLog("row: \(indexPath.row)")
            default: break
            }
        case 3:
            consoleLog("\(indexPath.section), \(indexPath.row)")
        default: break
        }
    }
    
    func logOutAction(sender: UIButton) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.alertMessage(message: "Are you sure you want to log out?", titleButton: "Log Out", titleButton2: "Cancel", action: {
                LoginModel.deleteUser()
                GIDSignIn.sharedInstance.signOut()
                self.router.perform(.logout, from: self)
            }, action2: {
                
            })
        } else {
            viewModel.showLogOutPopup(parent: self) {
                LoginModel.deleteUser()
                GIDSignIn.sharedInstance.signOut()
                self.router.perform(.logout, from: self)
            }
        }
    }
}
