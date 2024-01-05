//
//  LTConstrants.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import Foundation

let isIphoneX = UIScreen.size.height == 812 ? true : false
let navigationBarHeight : CGFloat = isIphoneX ? 88 : 64
let tabBarHeight : CGFloat = isIphoneX ? 83 : 50
let headerHeight : CGFloat = isIphoneX ? 0 : 30
let y_axis : CGFloat = isIphoneX ? 40 : 26
let x_axis : CGFloat = isIphoneX ? 20 : 10

let Main = UIStoryboard.init(name: "Main", bundle: nil)
let Account = UIStoryboard.init(name: "Account", bundle: nil)
let Setting = UIStoryboard.init(name: "Settings", bundle: nil)
let Appointment = UIStoryboard(name: "Appointment", bundle: nil)


func isValidateEmail(_ candidate: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
}

func dialNumber(number : String) {
    if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

func consoleLog(_ str: Any) {
    print("\(#function): \(str)")
}

let Loading = "Loading..."
