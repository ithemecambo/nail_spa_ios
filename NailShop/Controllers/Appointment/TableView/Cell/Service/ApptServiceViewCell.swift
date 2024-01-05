//
//  ApptServiceViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/11/23.
//

import UIKit

class ApptServiceViewCell: BaseCollectionViewCell {

    @IBOutlet weak var serviceProfileView: UIImageView!
    @IBOutlet weak var serviceTitleLabel: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var service: Service? {
        didSet {
            guard let model = service else { return }
            serviceTitleLabel.text = model.name
            serviceProfileView.image = UIImage(named: model.icon ?? "")
        }
    }
}
