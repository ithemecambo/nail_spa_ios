//
//  ProfileHeaderTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit

class ProfileHeaderTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var directionButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func websiteButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func callButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func directionButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
    }
    
    var profileData: ProfileDetailModel? {
        didSet {
            guard let model = profileData else { return }
            shopNameLabel.text = model.shopName
        }
    }
}
