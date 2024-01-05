//
//  SheetServiceTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/11/23.
//

import UIKit
import Foundation

protocol SheetServiceTableViewDelegate {
    func didSelect(indexPath: IndexPath)
}

protocol SheetServiceTableViewDataSource {
    func serviceItemLists() -> [ServiceModel]?
}

class SheetServiceTableView: UITableView {
    
    private var items: [ServiceModel]?
    
    var _delegate: SheetServiceTableViewDelegate?
    var _dataSource: SheetServiceTableViewDataSource?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable()
    }
    
    fileprivate func setupTable() {
        self.contentInset = .init(top: 20, left: 0, bottom: -16, right: 0)
        self.delegate   = self
        self.dataSource = self
        self.estimatedRowHeight = 100
        self.backgroundColor = .colorBackground
        self.register(SheetServiceTableViewCell.nib, forCellReuseIdentifier: SheetServiceTableViewCell.identifier)
        self.register(UINib(nibName: "OurServiceHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: OurServiceHeaderView.identifer)
    }
    
    override func reloadData() {
        items = _dataSource?.serviceItemLists() ?? []
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .left, offset: 100)
        UIView.animate(views: self.visibleCells, animations: [fromAnimation], duration: 0.4)
    }
}

extension SheetServiceTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items![section].isSelected! ? items![section].children?.count ?? 0 : 0 //items?[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: OurServiceHeaderView.identifer) as? OurServiceHeaderView else { return UIView() }
        headerView.service = items?[section]
        headerView.delegate = self
        headerView.tag = section
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SheetServiceTableViewCell.identifier, for: indexPath) as? SheetServiceTableViewCell else { return UITableViewCell() }
        cell.setupData = items?[indexPath.section].children?[indexPath.row]
        cell.separatorInset = .zero
        
        return cell
    }
}

extension SheetServiceTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items![indexPath.section].children![indexPath.row].isSelected?.toggle()
        let package = items![indexPath.section].children![indexPath.row]
        CoreDataManager.shared.updatePackage(id: Int16(package.id ?? 0), isSelected: package.isSelected ?? false)
        self.beginUpdates()
        self.reloadRows(at: [indexPath], with: .automatic)
        self.endUpdates()
    }
}

extension SheetServiceTableView: OurServiceHeaderViewDelegate {
    func toggleSection(header: OurServiceHeaderView, section: Int) {
        let isCollapsed = !items![section].isSelected!
        items![section].isSelected! = isCollapsed
        self.beginUpdates()
        self.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        self.endUpdates()
    }
}
