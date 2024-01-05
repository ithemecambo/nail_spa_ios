//
//  ProfileTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit
import Foundation
import ParallaxHeader

protocol ProfileTableViewDelegate {
    func didSelect(indexPath: IndexPath)
    func didScrollView(scrollView: UIScrollView)
}

protocol ProfileTableViewDataSource {
    func settingItemLists() -> [SettingSectionModel]
}

class ProfileTableView: UITableView {
    
    var _delegate: ProfileTableViewDelegate?
    var _dataSource: ProfileTableViewDataSource?
    
    var header = ProfileHeaderView()
    private var items: [SettingSectionModel] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable
    }
    
    override func reloadData() {
        items = _dataSource?.settingItemLists() ?? []
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .right, offset: 100)
        UIView.animate(views: visibleCells,
                       animations: [fromAnimation],
                       duration: 0.4)
    }
    
    private var setupTable: () {
        self.delegate           = self
        self.dataSource         = self
        self.estimatedRowHeight = 50
        self.backgroundColor    = .colorBackground
        self.rowHeight          = UITableView.automaticDimension
        self.register(ProfileTableViewCell.nib, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        self.setupHeader
    }
    
    private var setupHeader: () {
        if UIScreen.main.bounds.height <= 736 {
            header.frame = CGRect(x: UIScreen.main.bounds.origin.x, y: 0, width:  UIScreen.width, height:  UIScreen.height * 0.4)
        } else {
            header.frame = CGRect(x: UIScreen.main.bounds.origin.x, y: 0, width:  UIScreen.width, height:  UIScreen.height * 0.28)
        }
        parallaxHeader.view           =  header
        parallaxHeader.height         =  header.frame.size.height
        parallaxHeader.mode           =  .topFill
        parallaxHeader.minimumHeight  =  0
    }
}

extension ProfileTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        cell.setting = items[indexPath.section].items?[indexPath.row]
        cell.separatorInset = .zero
        
        return cell
    }
}

extension ProfileTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _delegate?.didSelect(indexPath: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _delegate?.didScrollView(scrollView: scrollView)
    }
}
