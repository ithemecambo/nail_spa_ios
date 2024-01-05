//
//  SettingsTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/7/23.
//

import UIKit

class SettingsTableViewCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var circleProgressView: UIView!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        switchButton.onTintColor = .colorApp
        switchButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func didClickSwitchButton(_ sender: UISwitch) {
        
    }
    
    var settingViewModel: AppSettingModel? {
        didSet {
            guard let model = settingViewModel else { return }
            titleLabel.text = model.title
            
            switch model.type {
            case .text:
                valueLabel.text = model.value
                valueLabel.isHidden = false
                switchButton.isHidden = true
                arrowImageView.isHidden = true
                flagImageView.isHidden = true
                
            case .option:
                switchButton.isHidden = false
                valueLabel.isHidden = true
                arrowImageView.isHidden = true
                flagImageView.isHidden = true
                
            case .icon:
                valueLabel.isHidden = true
                switchButton.isHidden = true
                arrowImageView.isHidden = true
                flagImageView.isHidden = false
                flagImageView.image = UIImage(named: model.image)
                
            case .arrow:
                valueLabel.isHidden = true
                switchButton.isHidden = true
                flagImageView.isHidden = true
                arrowImageView.isHidden = false
            case .none:
                valueLabel.isHidden = true
                switchButton.isHidden = true
                flagImageView.isHidden = true
                arrowImageView.isHidden = true
            }
        }
    }
}
