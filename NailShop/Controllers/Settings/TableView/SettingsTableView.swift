//
//  SettingsTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/7/23.
//

import UIKit
import Foundation

protocol SettingsTableViewDelegate {
    func didSelect(indexPath: IndexPath)
    func logOutAction(sender: UIButton)
}

protocol SettingsTableViewDataSource {
    func settingItemLists() -> [AppSettingSectionModel]
}

class SettingsTableView: UITableView {
    
    var _delegate: SettingsTableViewDelegate?
    var _dataSource: SettingsTableViewDataSource?
    
    private var items: [AppSettingSectionModel]?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable()
    }
    
    fileprivate func setupTable() {
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor(named: "backgroundColor")
        self.register(SettingsTableViewCell.nib, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        self.register(SettingLogoutTableViewCell.nib, forCellReuseIdentifier: SettingLogoutTableViewCell.identifier)
    }
    
    override func reloadData() {
        items = _dataSource?.settingItemLists() ?? []
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .bottom, offset: 100)
        UIView.animate(views: self.visibleCells, animations: [fromAnimation], duration: 0.4)
    }
}

extension SettingsTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if items![indexPath.section].items![indexPath.row].action == .none {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
            cell.settingViewModel = items![indexPath.section].items![indexPath.row]
            cell.separatorInset = .zero
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingLogoutTableViewCell.identifier, for: indexPath) as? SettingLogoutTableViewCell else { return UITableViewCell() }
            cell.logoutButton.tag = indexPath.row
            cell.delegate = self
            
            return cell
        }
    }
}

extension SettingsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _delegate?.didSelect(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

extension SettingsTableView: SettingLogoutTableViewDelegate {
    func logOutAction(sender: UIButton) {
        _delegate?.logOutAction(sender: sender)
    }
}
