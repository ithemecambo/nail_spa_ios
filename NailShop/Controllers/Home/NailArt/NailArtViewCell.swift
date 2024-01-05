//
//  NailArtViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/20/23.
//

import UIKit

class NailArtViewCell: BaseCollectionViewCell {

    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var subMainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    var staffMember: StaffMemberModel? {
        didSet {
            guard let model = staffMember else { return }
            ratingLabel.text = "\(Int.random(in: 4...5))"
            nameLabel.text = model.nickName
            licenseLabel.text = "\(model.licenseNo ?? "---//---")"
            subMainView.backgroundColor = UIColor.init(hex: model.color ?? "")
            avatarImageView.loadImage(url: model.photoUrl ?? "")
        }
    }
}
