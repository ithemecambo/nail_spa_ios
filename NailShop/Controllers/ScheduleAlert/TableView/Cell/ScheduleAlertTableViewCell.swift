//
//  ScheduleAlertTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/25/23.
//

import UIKit

class ScheduleAlertTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var displayTimeLabel: UILabel!
    @IBOutlet weak var checkIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var scheduleAlertTimeViewModel: ScheduleAlertTimeModel? {
        didSet {
            guard let model = scheduleAlertTimeViewModel else { return }
            displayTimeLabel.text = model.displayTime
            checkIcon.isHidden = model.isSelected ? false : true
        }
    }
}
