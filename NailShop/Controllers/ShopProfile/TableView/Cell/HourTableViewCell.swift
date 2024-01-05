//
//  HourTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import UIKit

class HourTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var openingDayLabel: UILabel!
    @IBOutlet weak var openingHourLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var openingHour: BusinessHourModel? {
        didSet {
            guard let model = openingHour else { return }
            openingDayLabel.text = model.openingDay
            openingHourLabel.text = model.openingHour
            openingHourLabel.textColor = (model.openingHour == "Closed") ? .red : .black
        }
    }
}
