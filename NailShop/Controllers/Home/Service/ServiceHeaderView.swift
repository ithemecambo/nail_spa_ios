//
//  ServiceHeaderView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/21/23.
//

import UIKit
import Foundation

protocol ServiceHeaderViewDelegate {
    func toggleSection(header: ServiceHeaderView, section: Int)
}

class ServiceHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    static let identifer = "serviceHeaderView"
    var delegate: ServiceHeaderViewDelegate?
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerDidTapped)))
    }

    @objc fileprivate func headerDidTapped(sender: UITapGestureRecognizer) {
        guard let header = sender.view as? ServiceHeaderView else { return }
        delegate?.toggleSection(header: header, section: header.tag)
    }
    
    func setCollapsed(_ collapsed: Bool) {
//        arrowIcon.rotate(collapsed ? 0.0 : .pi / 2)
        arrowIcon.image = collapsed ? UIImage(systemName: "chevron.up"): UIImage(systemName: "chevron.down")
    }
    
    var service: Service? {
        didSet {
            guard let model = service else { return }
            photoImageView.image = UIImage(named: model.icon ?? "")
            serviceNameLabel.text = model.name ?? ""
            arrowIcon.image = model.isExpanded ? UIImage(systemName: "chevron.up"): UIImage(systemName: "chevron.down")
        }
    }
}
