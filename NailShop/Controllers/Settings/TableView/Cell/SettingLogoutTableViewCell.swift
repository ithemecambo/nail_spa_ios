//
//  SettingLogoutTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/14/23.
//

import UIKit

protocol SettingLogoutTableViewDelegate {
    func logOutAction(sender: UIButton)
}

class SettingLogoutTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var logoutButton: UIButton!
    
    var delegate: SettingLogoutTableViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        delegate?.logOutAction(sender: sender)
    }
}
