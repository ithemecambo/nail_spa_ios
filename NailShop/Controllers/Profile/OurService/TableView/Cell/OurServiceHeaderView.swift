//
//  OurServiceHeaderView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit
import Foundation

protocol OurServiceHeaderViewDelegate {
    func toggleSection(header: OurServiceHeaderView, section: Int)
}

class OurServiceHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    static let identifer = "serviceHeaderCell"
    var delegate: OurServiceHeaderViewDelegate?
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerDidTapped)))
    }

    @objc fileprivate func headerDidTapped(sender: UITapGestureRecognizer) {
        guard let header = sender.view as? OurServiceHeaderView else { return }
        delegate?.toggleSection(header: header, section: header.tag)
    }
    
    var service: ServiceModel? {
        didSet {
            guard let model = service else { return }
            photoImageView.loadImage(url: model.photoUrl ?? "")
            serviceNameLabel.text = model.name?.uppercased() ?? ""
            UIView.animate(withDuration: 0.3, animations: {
                self.arrowIcon.transform = model.isSelected! ? CGAffineTransform(rotationAngle: .pi) : .identity
                //model.isExpanded ? self.mainView.roundCorners([.topLeft, .topRight], radius: 10): (self.mainView.cornerRadius = 10)
            })
        }
    }
}
