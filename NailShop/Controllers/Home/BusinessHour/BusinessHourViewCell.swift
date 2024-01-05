//
//  BusinessHourViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/20/23.
//

import UIKit

class BusinessHourViewCell: BaseTableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var businessHour: BusinessOpenHourModel? {
        didSet {
            guard let model = businessHour else { return }
            dayLabel.text = model.day
            hourLabel.text = model.hour
            hourLabel.textColor = (model.hour == "Closed")
                ? .red: UIColor(named: "textColor")
            hourLabel.textAlignment = (model.hour == "Closed") 
                ? .center: .right
        }
    }
}
