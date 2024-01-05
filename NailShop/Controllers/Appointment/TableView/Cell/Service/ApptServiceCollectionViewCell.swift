//
//  ApptServiceCollectionViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/17/23.
//

import UIKit

class ApptServiceCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var tableView: UITableView!
    var items: [ServiceModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        self.setupTable()
    }
    
    fileprivate func setupTable() {
        self.tableView.contentInset = .init(top: 20, left: 0, bottom: -16, right: 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.backgroundColor = .colorBackground
        self.tableView.rowHeight  = UITableView.automaticDimension
        self.tableView.register(OurServiceTableViewCell.nib, forCellReuseIdentifier: OurServiceTableViewCell.identifier)
        self.tableView.register(UINib(nibName: "OurServiceHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: OurServiceHeaderView.identifer)
    }
}

extension ApptServiceCollectionViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return items[section].isExpanded ? items[section].items?.count ?? 0 : 0
        return items[section].children?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: OurServiceHeaderView.identifer) as? OurServiceHeaderView else { return UIView() }
        headerView.service = items[section]
        headerView.delegate = self
        headerView.tag = section
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OurServiceTableViewCell.identifier, for: indexPath) as? OurServiceTableViewCell else { return UITableViewCell() }
        cell.setupItem = items[indexPath.section].children?[indexPath.row]
        cell.separatorInset = .zero
        cell.layoutIfNeeded()
        
        return cell
    }
}

extension ApptServiceCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

extension ApptServiceCollectionViewCell: OurServiceHeaderViewDelegate {
    func toggleSection(header: OurServiceHeaderView, section: Int) {
        let isCollapsed = !items[section].isSelected!
        items[section].isSelected! = isCollapsed
        self.tableView.beginUpdates()
        self.tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        self.tableView.endUpdates()
    }
}
