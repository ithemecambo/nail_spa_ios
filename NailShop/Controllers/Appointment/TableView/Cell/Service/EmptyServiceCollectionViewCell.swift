//
//  EmptyServiceCollectionViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/11/23.
//

import UIKit

protocol EmptyServiceCollectionButtonDelegate {
    func didAddServiceButton(index: Int)
}

class EmptyServiceCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var addServiceButton: UIButton!
    @IBOutlet weak var serviceLabel: UILabel!
    var delegate: EmptyServiceCollectionButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        serviceLabel.text = "You can skip add service, if you want.\n"
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDidTapped(_:))))
    }
    
    @objc func handleDidTapped(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view as? EmptyServiceCollectionViewCell else { return }
        delegate?.didAddServiceButton(index: view.tag)
    }

    @IBAction func addServiceButtonTapped(_ sender: UIButton) {
        delegate?.didAddServiceButton(index: sender.tag)
    }
}
