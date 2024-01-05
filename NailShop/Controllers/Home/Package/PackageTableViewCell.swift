//
//  PackageTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/22/23.
//

import UIKit

protocol PackageButtonDelegate {
    func bookingTapped(index: Int)
    func didServiceSelect(index: Int)
}

class PackageTableViewCell: BaseTableViewCell {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableConstraintHeight: NSLayoutConstraint!
    
    var delegate: PackageButtonDelegate?
    var services: [PackageModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTable()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func bookingButtonTapped(_ sender: UIButton) {
        delegate?.bookingTapped(index: sender.tag)
    }
    
    fileprivate func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(PackageViewCell.nib, forCellReuseIdentifier: PackageViewCell.identifier)
    }
}

extension PackageTableViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.prefix(5).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageViewCell.identifier, for: indexPath) as? PackageViewCell else { return UITableViewCell() }
        cell.service = services.prefix(5)[indexPath.row]
        tableConstraintHeight.constant = CGFloat(services.prefix(5).count) * 70
        
        return cell
    }
}

extension PackageTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didServiceSelect(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
