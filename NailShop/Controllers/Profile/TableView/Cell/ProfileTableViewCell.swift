//
//  ProfileTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/7/23.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var setting: SettingModel? {
        didSet {
            guard let model = setting else { return }
            logoImageView.image = UIImage(systemName: model.icon ?? "")
            titleLabel.text = model.title ?? ""
        }
    }
}
