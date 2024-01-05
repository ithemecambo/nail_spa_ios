//
//  GalleryViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/20/23.
//

import UIKit

class GalleryViewCell: BaseCollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    var gallery: GalleryModel? {
        didSet {
            guard let model = gallery else { return }
            photoImageView.loadImage(url: model.photoUrl ?? "")
        }
    }
}
