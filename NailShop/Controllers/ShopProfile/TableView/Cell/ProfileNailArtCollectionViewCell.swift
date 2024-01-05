//
//  ProfileNailArtCollectionViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit

class ProfileNailArtCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var nailArt: NailArtModel? {
        didSet {
            guard let model = nailArt else { return }
            fullNameLabel.text = model.name
        }
    }
}
