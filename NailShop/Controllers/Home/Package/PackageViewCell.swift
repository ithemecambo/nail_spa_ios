//
//  PackageViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/21/23.
//

import UIKit

class PackageViewCell: BaseTableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var service: PackageModel? {
        didSet {
            guard let model = service else { return }
            serviceNameLabel.text = model.name?.uppercased()
            photoImageView.loadImage(url: model.photoUrl ?? "")
        }
    }
}
