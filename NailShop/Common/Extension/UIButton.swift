//
//  UIButton.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/21/23.
//

import UIKit
import Foundation

extension UIButton {
    func centerImageAndButton(_ gap: CGFloat, imageOnTop: Bool) {
        
        guard let imageView = self.currentImage,
            let titleLabel = self.titleLabel?.text else { return }
        
        let sign: CGFloat = imageOnTop ? 1 : -1
        self.configuration?.titlePadding = 10
        self.configuration?.imagePadding = 10
        self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: (imageView.size.height + gap) * sign, leading: -imageView.size.width, bottom: 0, trailing: 0)
        
        let titleSize = titleLabel.size(withAttributes:[NSAttributedString.Key.font: self.titleLabel!.font!])
        self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: -(titleSize.height + gap) * sign, leading: 0, bottom: 0, trailing: -titleSize.width)
    }
}
