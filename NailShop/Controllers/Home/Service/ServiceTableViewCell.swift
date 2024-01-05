//
//  ServiceTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit

class ServiceTableViewCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var serviceAvatarImageView: UIImageView!
    @IBOutlet weak var arrowIcon: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewConstraintHeight: NSLayoutConstraint!
    
    var services: [Service] = []
    private (set) var maxHeight: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTable()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(ServiceItemTableViewCell.nib, forCellReuseIdentifier: ServiceItemTableViewCell.identifier)
        self.tableView.register(UINib(nibName: "ServiceHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: ServiceHeaderView.identifer)
        self.tableView.backgroundColor = .white
        self.tableView.sectionHeaderTopPadding = 1.0
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //let height = tableView.contentSize.height
        //tableViewConstraintHeight.constant = height
        if keyPath == "contentSize" {
            if object is UITableView {
                if let newValue = change?[.newKey] {
                    let newSize = newValue as! CGSize
                    self.tableViewConstraintHeight.constant = newSize.height
                }
            }
        }
    }
    
    func getHeight() -> CGFloat {
        return CGFloat(services.count) * 70.0
    }
    
    deinit {
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
}

extension ServiceTableViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services[section].isExpanded ? (services[section].items?.count ?? 0) : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ServiceHeaderView.identifer) as? ServiceHeaderView else { return UIView() }
        header.service = services[section]
        header.delegate = self
        header.tag = section
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceItemTableViewCell.identifier, for: indexPath) as? ServiceItemTableViewCell else { return UITableViewCell() }
        cell.service = services[indexPath.section].items?[indexPath.row]
        cell.layoutIfNeeded()
//        tableView.setNeedsLayout()
//        tableViewConstraintHeight.constant = getHeight()
        tableViewConstraintHeight.constant = self.tableView.contentSize.height
//        tableView.layoutIfNeeded()
        
        return cell
    }
}

extension ServiceTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

extension ServiceTableViewCell: ServiceHeaderViewDelegate {
    func toggleSection(header: ServiceHeaderView, section: Int) {
        let isCollapsed = !services[section].isExpanded
            // Toggle collapse
        services[section].isExpanded = isCollapsed
        header.setCollapsed(isCollapsed)
        
        // Reload the whole section
        tableView.beginUpdates()
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        tableView.reloadData()
        tableView.endUpdates()
    }
}
