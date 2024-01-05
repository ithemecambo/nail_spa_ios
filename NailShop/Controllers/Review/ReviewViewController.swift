//
//  ReviewViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/5/23.
//

import UIKit
import Cosmos
import MaterialComponents

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var mainPopView: UIView!
    @IBOutlet weak var feelingLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var commentView: UIView!
    
    var commentTextArea: MDCOutlinedTextArea!
    
    static func instantiate() -> ReviewViewController {
        let controller = ReviewViewController(nibName: "ReviewViewController", bundle: nil)
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextArea = MDCOutlinedTextArea(frame: CGRect(x: 0, y: 10, width: commentView.frame.width - (UIScreen.main.bounds.height >= 812 ? 95: 20) , height: 180))
        commentTextArea.label.text = "Comment"
        commentTextArea.setOutlineColor(.systemGray, for: .normal)
        commentTextArea.setOutlineColor(.systemGreen, for: .editing)
        commentTextArea.minimumNumberOfVisibleRows = 4
        commentTextArea.textView.font = .systemFont(ofSize: 15)
        commentView.addSubview(commentTextArea)
    }
}
