//
//  NoDataAvailableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit

class NoDataAvailableView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
    }
    
    private func setupView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NoDataAvailableView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.backgroundColor = .clear
        showAnimation()
    }
    
    func showAnimation() {
        let fromAnimation = AnimationType.from(direction: .bottom, offset: 60)
        UIView.animate(views: [imageView, titleLabel],
                       animations: [fromAnimation],
                       duration: 0.4)
    }
}
