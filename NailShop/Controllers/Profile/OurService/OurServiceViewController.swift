//
//  OurServiceViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/5/23.
//

import UIKit

class OurServiceViewController: BaseViewController {
    
    @IBOutlet weak var tableView: OurServiceTableView! {
        didSet {
            self.tableView._dataSource = self
        }
    }
    
    var viewModel: OurServiceViewModel!
    private var services: [ServiceModel] = []
    
    static func instantiate() -> OurServiceViewController {
        let controller = Account.instantiateViewController(withIdentifier: String(describing: self)) as! OurServiceViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Our Service"
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        self.startLoading(text: "Loading...")
        self.getServices
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let viewModel = viewModel else { return }
        if viewModel.source != "home" {
            tabBarController?.tabBar.isHidden = false
            navigationController?.isNavigationBarHidden = true
        } else {
            tabBarController?.tabBar.isHidden = false
            navigationController?.isNavigationBarHidden = false
        }
    }
}

extension OurServiceViewController {
    fileprivate var getServices: () {
        viewModel.getServices { result in
            switch result {
            case .success(let services):
                self.stopLoading()
                self.services = services
            case .failed(let error):
                self.stopLoading()
                self.alertMessage(message: error)
            }
            self.tableView.reloadData()
        }
    }
}

extension OurServiceViewController: OurServiceTableViewDataSource {
    func serviceItemLists() -> [ServiceModel] {
        return self.services
    }
}
