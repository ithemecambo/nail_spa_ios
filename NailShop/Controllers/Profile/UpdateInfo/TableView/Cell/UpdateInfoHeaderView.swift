//
//  UpdateInfoHeaderView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit
import Foundation

protocol UpdateInfoHeaderViewDelegate {
    func uploadProfilebuttonTapped(sender: UIButton)
}

class UpdateInfoHeaderView: UIView {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var delegate: UpdateInfoHeaderViewDelegate?
    
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
        let nib = UINib(nibName: "UpdateInfoHeaderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        delegate?.uploadProfilebuttonTapped(sender: sender)
    }
}
