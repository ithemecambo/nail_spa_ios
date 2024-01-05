//
//  ScheduleAlertViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/25/23.
//

import UIKit

class ScheduleAlertViewController: UIViewController {

    @IBOutlet weak var tableView: ScheduleAlertTableView! {
        didSet {
            self.tableView._dataSource = self
            self.tableView.reloadData()
        }
    }
    @IBOutlet weak var scheduleConstraintHeight: NSLayoutConstraint!
    
    static func instantiate() -> ScheduleAlertViewController {
        let controller = ScheduleAlertViewController(nibName: "ScheduleAlertViewController", bundle: nil)
        return controller
    }
    
    private var scheduleAlertTimes: [ScheduleAlertTimeModel] = ScheduleAlertTimeModel.scheduleAlertTimes
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ScheduleAlertViewController: ScheduleAlertTableViewDataSource {
    func scheduleAlertTimeItmeLists() -> [ScheduleAlertTimeModel]? {
        return scheduleAlertTimes
    }
}
