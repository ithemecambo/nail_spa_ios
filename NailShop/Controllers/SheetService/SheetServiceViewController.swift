//
//  SheetServiceViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/11/23.
//

import UIKit

protocol SheetServiceSaveDataDelegate {
    func saveDataCompleted(items: [PackageModel])
}

class SheetServiceViewController: BaseViewController {
    
    @IBOutlet weak var tableView: SheetServiceTableView! {
        didSet {
            self.tableView._dataSource = self
        }
    }
    
    var delegate: SheetServiceSaveDataDelegate?
    var viewModel: SheetServiceViewModel!
    private var services: [ServiceModel]?
    private var selectedServices: [ServiceModel]?
    
    static func instantiate() -> SheetServiceViewController {
        let controller = Appointment.instantiateViewController(withIdentifier: String(describing: self)) as! SheetServiceViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Services"
        guard let viewModel = viewModel else { return }
        if !UserDefaults.standard.bool(forKey: UserDefaults.Keys.savedInLocal) {
            UserDefaults.standard.setValue(true, forKey: UserDefaults.Keys.savedInLocal)
            self.getServices
        } else {
            viewModel.getServiceData { result in
                switch result {
                case .success(let services):
                    self.services = services
                    self.tableView.reloadData()
                case .failed(_): break
                }
            }
        }
    }
    
    fileprivate var getServices: () {
        viewModel.getServices { result in
            switch result {
            case .success(let services):
                self.services = services
                ThreadHelper.delay(dalay: 0.5) {
                    self.viewModel.saveServiceData(services: services) { result in
                        switch result {
                        case .success(_): break
                        case .failed(let error):
                            self.alertMessage(message: error)
                        }
                    }
                }
            case .failed(let error):
                self.alertMessage(message: error)
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
        guard let viewModel = viewModel else { return }
        delegate?.saveDataCompleted(items: viewModel.selectedPackages())
    }
}

extension SheetServiceViewController: SheetServiceTableViewDataSource {
    func serviceItemLists() -> [ServiceModel]? {
        return services
    }
}
