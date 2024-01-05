//
//  OpeningHourTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import UIKit

class OpeningHourTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableConstraintHeight: NSLayoutConstraint!
    
    var openingHours: [BusinessHourModel] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        self.setupTable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.separatorStyle = .none
        tableView.register(HourTableViewCell.nib, forCellReuseIdentifier: HourTableViewCell.identifier)
    }
}

extension OpeningHourTableViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openingHours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HourTableViewCell.identifier, for: indexPath) as? HourTableViewCell else { return UITableViewCell() }
        cell.openingHour = openingHours[indexPath.row]
        tableConstraintHeight.constant = CGFloat(openingHours.count * 40)
        
        return cell
    }
}

extension OpeningHourTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
