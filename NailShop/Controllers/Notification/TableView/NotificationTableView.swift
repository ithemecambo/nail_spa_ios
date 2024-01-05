//
//  NotificationTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit
import Foundation

protocol NotificationTableViewDelegate {
    
}

protocol NotificationTableViewDataSource {
    func notificationItemLists() -> [NotificationModel]?
}

class NotificationTableView: UITableView {
    
    private var notifications: [NotificationModel]?
    var _delegate: NotificationTableViewDelegate?
    var _dataSource: NotificationTableViewDataSource?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable
    }
    
    override func reloadData() {
        notifications = _dataSource?.notificationItemLists() ?? []
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .left, offset: 120)
        UIView.animate(views: visibleCells, animations: [fromAnimation], duration: 0.4)
    }
    
    private var setupTable: () {
        self.contentInset   = .init(top: 0, left: 0, bottom: 10, right: 0)
        self.delegate       = self
        self.dataSource     = self
        self.separatorStyle = .none
        self.estimatedRowHeight = 100
        self.backgroundColor = UIColor(named: "backgroundColor")
        self.rowHeight = UITableView.automaticDimension
        self.register(NotificationTableViewCell.nib, forCellReuseIdentifier: NotificationTableViewCell.identifier)
    }
}

extension NotificationTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as? NotificationTableViewCell else { return UITableViewCell() }
        cell.notification = notifications?[indexPath.row]
        
        return cell
    }
}

extension NotificationTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
