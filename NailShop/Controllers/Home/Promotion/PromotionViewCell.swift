//
//  PromotionViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/20/23.
//

import UIKit
import FSPagerView

class PromotionViewCell: FSPagerViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var avatarView: BannerView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var promotionTitleLabel: UILabel!
    @IBOutlet weak var highlightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var promotion: PromotionModel? {
        didSet {
            guard let model = promotion else { return }
            avatarImageView.loadImage(url: model.photoUrl ?? "")
            percentageLabel.text = "\(Int(model.discount ?? 0.0))%\nOFF"
            promotionTitleLabel.text = model.title
            mainView.backgroundColor = .init(hex: model.color ?? "")
        }
    }
}


class BannerView: UIView {
    override func draw(_ rect: CGRect) {
        let layerHeight = layer.frame.height
        let layerWidth = layer.frame.width
        
        let bezierPath = UIBezierPath()
        
        let pointA = CGPoint(x: 0, y: 0)
        let pointB = CGPoint(x: layerWidth, y: 0)
        let pointC = CGPoint(x: layerWidth * 2 / 2.5, y: layerHeight)
        let pointD = CGPoint(x: 0, y: layerHeight)
        
        bezierPath.move(to: pointA)
        bezierPath.addLine(to: pointB)
        bezierPath.addLine(to: pointC)
        bezierPath.addLine(to: pointD)
        bezierPath.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
    }
}
