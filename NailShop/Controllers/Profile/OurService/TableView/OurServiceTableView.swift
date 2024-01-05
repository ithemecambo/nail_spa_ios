//
//  OurServiceTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit
import Foundation

protocol OurServiceTableViewDataSource {
    func serviceItemLists() -> [ServiceModel]
}

class OurServiceTableView: UITableView {
    
    var _dataSource: OurServiceTableViewDataSource?
    private var items: [ServiceModel]?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable()
    }
    
    override func reloadData() {
        items = _dataSource?.serviceItemLists() ?? []
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .left, offset: 100)
        UIView.animate(views: self.visibleCells, animations: [fromAnimation], duration: 0.5)
    }
    
    fileprivate func setupTable() {
        self.contentInset = .init(top: 20, left: 0, bottom: -16, right: 0)
        self.delegate = self
        self.dataSource = self
        self.estimatedRowHeight = 100
        self.backgroundColor = .colorBackground
        self.rowHeight  = UITableView.automaticDimension
        self.register(OurServiceTableViewCell.nib, forCellReuseIdentifier: OurServiceTableViewCell.identifier)
        self.register(UINib(nibName: "OurServiceHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: OurServiceHeaderView.identifer)
    }
}

extension OurServiceTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items![section].isSelected! ? items![section].children?.count ?? 0 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: OurServiceHeaderView.identifer) as? OurServiceHeaderView else { return UIView() }
        headerView.service = items?[section]
        headerView.delegate = self
        headerView.tag = section
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OurServiceTableViewCell.identifier, for: indexPath) as? OurServiceTableViewCell else { return UITableViewCell() }
        cell.setupItem = items?[indexPath.section].children?[indexPath.row]
        cell.separatorInset = .zero
        
        return cell
    }
}

extension OurServiceTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

extension OurServiceTableView: OurServiceHeaderViewDelegate {
    func toggleSection(header: OurServiceHeaderView, section: Int) {
        let isCollapsed = !items![section].isSelected!
        items![section].isSelected! = isCollapsed
        self.beginUpdates()
        self.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        self.endUpdates()
    }
}
