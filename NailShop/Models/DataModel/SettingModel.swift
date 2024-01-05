//
//  SettingModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/7/23.
//

import UIKit
import Foundation


struct SettingSectionModel {
    let id: UUID = UUID()
    var header: String? = ""
    var items: [SettingModel]?
    
    static var sections: [SettingSectionModel] {
        return [
            SettingSectionModel(items: [
                SettingModel(icon: "shippingbox.circle", title: "Our Service"),
                SettingModel(icon: "person.crop.circle", title: "Update Information"),
                SettingModel(icon: "lock.circle", title: "Change Password"),
            ]),
            SettingSectionModel(items: [
                SettingModel(icon: "phone.bubble.left", title: "Contact Us"),
                SettingModel(icon: "map.circle", title: "Nail & Spa Springs"),
                SettingModel(icon: "exclamationmark.shield", title: "Term & Condition"),
            ]),
            SettingSectionModel(items: [
                SettingModel(icon: "moon.circle", title: "Dark Mode"),
                SettingModel(icon: "arrowshape.turn.up.left.circle", title: "Share App"),
                SettingModel(icon: "star.bubble", title: "Rating App"),
                SettingModel(icon: "gearshape.circle", title: "Settings"),
            ])
        ]
    }
}

struct SettingModel {
    let id: UUID = UUID()
    var icon: String?
    var title: String?
}

enum Theme: Int {
    case light
    case dark
    case device
}

extension Theme {
    var title: String {
        switch self {
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        case .device:
            return "System Mode"
        }
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .device:
            return .unspecified
        }
    }
}


struct DarkModeModel {
    let id: UUID = UUID()
    var title: String?
    var mode: Theme
    
    static var darkModes: [DarkModeModel] {
        return [
            DarkModeModel(title: "Light", mode: .light),
            DarkModeModel(title: "Dark", mode: .dark),
            DarkModeModel(title: "System Mode", mode: .device)
        ]
    }
}

enum SettingType {
    case icon
    case arrow
    case option
    case text
    case none
}

enum SettingAction: String {
    case none   = "none"
    case logout = "logout"
}

struct AppSettingSectionModel {
    var id: UUID = UUID()
    var header: String?
    var items: [AppSettingModel]?
    
    static var appSettings: [AppSettingSectionModel] {
        return [
            AppSettingSectionModel(items: [
                AppSettingModel(id: UUID(), title: "Language", image: "ic_usa_flag", type: .icon)
            ]),
            AppSettingSectionModel(items: [
                AppSettingModel(id: UUID(), title: "Notification", isEdit: true, type: .option)
            ]),
            AppSettingSectionModel(items: [
                AppSettingModel(id: UUID(), title: "Feedback", type: .arrow),
                AppSettingModel(id: UUID(), title: "Cache", type: .text, value: "0 MB"),
                AppSettingModel(id: UUID(), title: "Version", type: .text, value: "V 1.68.2"),
            ]),
            AppSettingSectionModel(items: [
                AppSettingModel(id: UUID(), title: "Log Out", type: .none, action: .logout)
            ])
        ]
    }
}

struct AppSettingModel {
    var id: UUID = UUID()
    var title   = ""
    var image   = ""
    var isEdit  = false
    var type: SettingType = .text
    var action: SettingAction = .none
    var value   = ""
}
