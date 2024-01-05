//
//  DarkModeTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit

class DarkModeTableViewCell: BaseTableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var checkIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupAnimation
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var darkMode: DarkModeModel? {
        didSet {
            guard let model = darkMode else { return }
            darkModeLabel.text = model.title
        }
    }
    
    fileprivate var setupAnimation: () {
        let fromAnimation = AnimationType.from(direction: .left, offset: 120)
        UIView.animate(views: [mainView], animations: [fromAnimation], duration: 0.4)
    }
}
