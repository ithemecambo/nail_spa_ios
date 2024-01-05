//
//  UpdateInfoTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit

class UpdateInfoTableViewCell: BaseTableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var profileView: ProfileInfo? {
        didSet {
            guard let model = profileView else { return }
            keyLabel.text = model.key
            valueLabel.text = model.value
            logoImageView.image = UIImage(systemName: model.icon)
        }
    }
}
