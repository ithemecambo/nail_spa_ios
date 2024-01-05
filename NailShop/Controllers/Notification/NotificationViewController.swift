//
//  NotificationViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit

class NotificationViewController: BaseViewController {

    @IBOutlet weak var tableView: NotificationTableView! {
        didSet {
            self.tableView._dataSource = self
        }
    }
    
    private var viewModel = NotificationViewModel()
    private var notifications: [NotificationModel] = []
    
    static func instantiate() -> NotificationViewController {
        let controller = Main.instantiateViewController(withIdentifier: String(describing: self)) as! NotificationViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notifications"
        self.startLoading(text: Loading)
        self.getNotifications
    }
}

extension NotificationViewController {
    fileprivate var getNotifications: () {
        viewModel.getNotifications { result in
            switch result {
            case .success(let data):
                self.stopLoading()
                self.notifications = data
            case .failed(let error):
                self.stopLoading()
                self.alertMessage(message: error)
            }
            self.tableView.reloadData()
        }
    }
}

extension NotificationViewController: NotificationTableViewDataSource {
    func notificationItemLists() -> [NotificationModel]? {
        return notifications
    }
}
