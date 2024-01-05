//
//  SheetServiceTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/11/23.
//

import UIKit

class SheetServiceTableViewCell: BaseTableViewCell {

    @IBOutlet weak var checkIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var setupData: PackageModel? {
        didSet {
            guard let model = setupData else { return }
            titleLabel.text = model.name?.capitalized
            priceLabel.text = "$\(model.price ?? 0.0)\(model.symbol ?? "")"
            checkIcon.isHidden = model.isSelected! ? false : true
            descLabel.text = model.description
        }
    }
}
