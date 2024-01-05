//
//  TermTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/14/23.
//

import UIKit
import Foundation
import ParallaxHeader

class TermTableView: UITableView {

    private var header = TermHeaderView()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable
    }
    
    fileprivate var setupTable: () {
        self.delegate       = self
        self.dataSource     = self
        self.estimatedRowHeight = 100
        self.separatorStyle = .none
        self.rowHeight      = UITableView.automaticDimension
        self.backgroundColor = .colorBackground
        self.register(TermTableViewCell.nib, forCellReuseIdentifier: TermTableViewCell.identifier)
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
    }
    
    override func reloadData() {
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .bottom, offset: 100)
        UIView.animate(views: self.visibleCells, animations: [fromAnimation], duration: 0.4)
    }
}

extension TermTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TermTableViewCell.identifier, for: indexPath) as? TermTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

extension TermTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
