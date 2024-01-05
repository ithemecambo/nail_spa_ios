//
//  ProfileViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import MapKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: ProfileTableView! {
        didSet {
            self.tableView._delegate    = self
            self.tableView._dataSource  = self
        }
    }
    
    private var settings: [SettingSectionModel] = SettingSectionModel.sections
    private var navigationView: NavigationAppBarView!
    private var router = DefaultProfileRouter()
    
    static func instantiate() -> ProfileViewController {
        let controller = Main.instantiateViewController(withIdentifier: String(describing: self)) as! ProfileViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationHeader
        CoreDataManager.shared.delete()
        guard let profile = UserProfielModel.getProfile() else { return }
        profile.photoUrl == "" ? 
        (tableView.header.profileImageView.image = UIImage(named: "avatar-profile")):
        (tableView.header.profileImageView.loadImage(url: "\(Configuration.baseUrl)\(profile.photoUrl ?? "")"))
    }
    
    private var setupNavigationHeader: () {
        self.navigationController?.isNavigationBarHidden = true
        let navibarHeight: CGFloat = navigationController!.navigationBar.bounds.height
        let statusbarHeight: CGFloat = statusBarHeight
        navigationView = NavigationAppBarView()
        navigationView.titleLabel.text = "Senghort Kheang"
        navigationView.constraintOffY.constant = UIDevice.isiPhoneX ? 25 : 9
        navigationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width,
                                      height: navibarHeight + statusbarHeight)
        navigationView.backgroundColor = .white
        navigationView.alpha = 0.0
        view.addSubview(navigationView)
    }
}

extension ProfileViewController: ProfileTableViewDataSource {
    func settingItemLists() -> [SettingSectionModel] {
        return settings
    }
}

extension ProfileViewController: ProfileTableViewDelegate {
    func didSelect(indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.router.perform(.ourService("profile"), from: self)
            case 1:
                self.router.perform(.updateInformation, from: self)
            case 2:
                self.router.perform(.changePassword(""), from: self)
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                self.router.perform(.contactUs, from: self)
            case 1:
                self.router.perform(.aboutUs, from: self)
            case 2:
                self.router.perform(.termCondition, from: self)
            default: break
            }
        case 2:
            switch indexPath.row {
            case 0:
                self.router.perform(.darkMode, from: self)
            case 1:
                self.router.perform(.shareApp, from: self)
            case 2:
                self.router.perform(.ratingApp, from: self)
            case 3:
                self.router.perform(.setting, from: self)
            default: break
            }
        default:
            break
        }
    }
    
    func didScrollView(scrollView: UIScrollView) {
        let offset: CGFloat = scrollView.contentOffset.y
        if offset < -200 {
            navigationView.alpha = 0.0
        } else {
            let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(-310) + (navigationView.frame.height) - offset) / (navigationView.frame.height))
            navigationView.alpha = CGFloat(alpha)
        }
    }
}
