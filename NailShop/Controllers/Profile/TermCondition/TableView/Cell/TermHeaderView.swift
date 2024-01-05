//
//  TermHeaderView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/14/23.
//

import UIKit
import Foundation

class TermHeaderView: UIView {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView
    }
    
    private var setupView: () {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TermHeaderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
}
