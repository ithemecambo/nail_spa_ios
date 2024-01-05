//
//  ApptNailArtCollectionViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/17/23.
//

import UIKit

class ApptNailArtCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectedPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectedPicture.alpha = 0
    }

    var nailArt: NailArtModel? {
        didSet {
            guard let model = nailArt else { return }
            nameLabel.text = model.name
        }
    }
    
    var staffMember: StaffMemberModel? {
        didSet {
            guard let model = staffMember else { return }
            nameLabel.text = model.nickName
            avatarImageView.loadImage(url: "\(Configuration.baseUrl)\(model.photoUrl ?? "")")
            mainView.backgroundColor = UIColor.init(hex: model.color ?? "").withAlphaComponent(0.45)
        }
    }
}
