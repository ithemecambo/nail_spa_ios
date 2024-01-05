//
//  ApptTimeSlotCollectionViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/17/23.
//

import UIKit

class ApptTimeSlotCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    var timeSlot: TimeSlotModel? {
        didSet {
            guard let model = timeSlot else { return }
            timeLabel.text = model.time
         }
    }
}
