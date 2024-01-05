//
//  BaseCollectionViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/14/23.
//

import UIKit
import Foundation

class BaseCollectionViewCell: UICollectionViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
