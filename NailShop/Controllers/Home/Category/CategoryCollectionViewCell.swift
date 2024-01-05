//
//  CategoryCollectionViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/18/23.
//

import UIKit

class CategoryCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.backgroundColor = .systemGray6.withAlphaComponent(0.5)
    }
}
