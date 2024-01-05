//
//  UIImageView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import Foundation
import Kingfisher

extension UIImageView {
    
    func loadImage(url: String, placeHolderImage: String = "", handler: (() -> ())? = nil ) {
        if url.isEmpty {
            self.image = UIImage(named: placeHolderImage)
        } else {
            
            if let url = URL(string: url) {
                
                let placeHolder = placeHolderImage.isEmpty ? nil : UIImage(named: placeHolderImage)
                
                self.kf.setImage(with: url,
                                 placeholder: placeHolder,
                                 options:  [.transition(.fade(0.8))],
                                 progressBlock: nil,
                                 completionHandler: nil)
            } else {
                self.image = UIImage(named: placeHolderImage)
            }
        }
    }
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, withComplection complection: @escaping (UIImage?) -> () = {_ in }) {
        DispatchQueue.main.async {
            self.contentMode = mode
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { complection(nil); return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
                complection(image)
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, withComplection complection: @escaping (UIImage?) -> () = {_ in }) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode, withComplection: complection)
    }
    
    func getImageName() -> String {
        if let image = self.image, let imageName = image.accessibilityIdentifier {
            return imageName
        } else {
            return "nil"
        }
    }
}
