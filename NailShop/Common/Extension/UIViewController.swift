//
//  UIViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit
import Foundation

extension UIViewController {
    
    var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                    .filter {$0.activationState == .foregroundActive }
                    .map {$0 as? UIWindowScene }
                    .compactMap { $0 }
                    .first?.windows
                    .filter({ $0.isKeyWindow }).first?
                    .windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    func alertMessage(title : String = "Nail & Spa", message: String, yesAction: (() ->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (actions) in
            yesAction?()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertMessage(title : String = "Nail & Spa", message: String, titleButton: String = "Ok" ,titleButton2: String = "" , action: (() ->())? = nil , action2: (() ->())? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: titleButton, style: .default, handler: { (actions) in
            action?()
        }))
        if titleButton2 != "" {
            alert.addAction(UIAlertAction(title: titleButton2, style: .default, handler: { (actions) in
                action2?()
            }))
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func contactUs(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in
                if success == false {
                    let url = URL(string: urlString)
                    if UIApplication.shared.canOpenURL(url!) {
                        UIApplication.shared.open(url!)
                    }
                }
            })
        }
    }

}
