//
//  NotificationTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit

class NotificationTableViewCell: BaseTableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imageConstraintHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var notification: NotificationModel? {
        didSet {
            guard let model = notification else { return }
            titleLabel.text = model.title
            subTitleLabel.text = model.subtitle
            photoImageView.loadImage(url: "\(Configuration.baseUrl)\(model.bannerUrl ?? "")")
            imageConstraintHeight.constant = (model.bannerUrl == nil) ? 0 : (UIScreen._height / 2.5) - 50
        }
    }
}
