//
//  OurServiceTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit

class OurServiceTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var setupItem: PackageModel? {
        didSet {
            guard let model = setupItem else { return }
            titleLabel.text = model.name?.capitalized
            priceLabel.text = "$\(model.price ?? 0.0)\(model.symbol ?? "")"
            model.description == "" ? (descLabel.text = ""): (descLabel.text = "\n\(model.description ?? "")")
        }
    }
}
