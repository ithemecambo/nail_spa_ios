//
//  UpdateInfoTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit
import Foundation
import ParallaxHeader

protocol UpdateInfoTableViewDelegate {
    func didScrollView(scrollView: UIScrollView)
    func profileButtonTapped(sender: UIButton)
}

protocol UpdateInfoTableViewDataSource {
    func profileItemList() -> [ProfileInfo]?
}

class UpdateInfoTableView: UITableView {
    
    var _delegate: UpdateInfoTableViewDelegate?
    var _dataSource: UpdateInfoTableViewDataSource?
    private var items: [ProfileInfo] = []
    var header = UpdateInfoHeaderView()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable
    }
    
    override func reloadData() {
        items = _dataSource?.profileItemList() ?? []
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .right, offset: 100)
        UIView.animate(views: visibleCells,
                       animations: [fromAnimation],
                       duration: 0.4)
    }
    
    fileprivate var setupTable: () {
        self.delegate       = self
        self.dataSource     = self
        self.estimatedRowHeight = 50
        self.backgroundColor    = .colorBackground
        self.rowHeight      = UITableView.automaticDimension
        self.register(UpdateInfoTableViewCell.nib, forCellReuseIdentifier: UpdateInfoTableViewCell.identifier)
        self.setupHeader
    }
    
    fileprivate var setupHeader: () {
        if UIScreen.main.bounds.height <= 736 {
            header.frame = CGRect(x: UIScreen.main.bounds.origin.x, y: 0, width:  UIScreen.width, height:  UIScreen.height * 0.4)
        } else {
            header.frame = CGRect(x: UIScreen.main.bounds.origin.x, y: 0, width:  UIScreen.width, height:  UIScreen.height * 0.28)
        }
        parallaxHeader.view           =  header
        parallaxHeader.height         =  header.frame.size.height
        parallaxHeader.mode           =  .topFill
        parallaxHeader.minimumHeight  =  0
        header.delegate               = self
    }
}

extension UpdateInfoTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpdateInfoTableViewCell.identifier, for: indexPath) as? UpdateInfoTableViewCell else { return UITableViewCell() }
        cell.profileView = items[indexPath.row]
        cell.separatorInset = .zero
        
        return cell
    }
}

extension UpdateInfoTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _delegate?.didScrollView(scrollView: scrollView)
    }
}

extension UpdateInfoTableView: UpdateInfoHeaderViewDelegate {
    func uploadProfilebuttonTapped(sender: UIButton) {
        _delegate?.profileButtonTapped(sender: sender)
    }
}
