//
//  AdditionalTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/19/23.
//

import UIKit

class AdditionalTableViewCell: BaseTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
