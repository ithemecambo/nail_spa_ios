//
//  TermConditionViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit

class TermConditionViewController: UIViewController {
    
    @IBOutlet weak var tableView: TermTableView!
    
    static func instantiate() -> TermConditionViewController {
        let controller = Setting.instantiateViewController(identifier: String(describing: self)) as! TermConditionViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Term & Condition"
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
}
