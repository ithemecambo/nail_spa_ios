//
//  BaseTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/14/23.
//

import UIKit
import Foundation

class BaseTableViewCell: UITableViewCell {

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
