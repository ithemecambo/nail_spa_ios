//
//  ServiceItemTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/19/23.
//

import UIKit

class ServiceItemTableViewCell: BaseTableViewCell {

    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var serviceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var service: ServiceItemModel? {
        didSet {
            guard let model = service else { return }
            serviceLabel.text = model.name?.capitalized
        }
    }
}
