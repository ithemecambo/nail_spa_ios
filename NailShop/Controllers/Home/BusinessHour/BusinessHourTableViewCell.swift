//
//  BusinessHourTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/20/23.
//

import UIKit

class BusinessHourTableViewCell: BaseTableViewCell {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableConstraintHeight: NSLayoutConstraint!
    
    var businessHours: [BusinessOpenHourModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
        self.setupTable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(BusinessHourViewCell.nib, forCellReuseIdentifier: BusinessHourViewCell.identifier)
    }
}

extension BusinessHourTableViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessHours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BusinessHourViewCell.identifier, for: indexPath) as? BusinessHourViewCell else { return UITableViewCell() }
        cell.businessHour = businessHours[indexPath.row]
        tableConstraintHeight.constant = CGFloat(businessHours.count * 50)
        return cell
    }
}

extension BusinessHourTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
