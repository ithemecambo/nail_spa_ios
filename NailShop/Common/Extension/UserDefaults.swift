//
//  UserDefaults.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import Foundation

extension UserDefaults {
    struct Keys {
        static let isLogin      = "isLogin"
        static let onboarding   = "onboarding"
        static let isInstalled  = "isInstalled"
        static let savedInLocal = "savedInLocal"
    }
    
    var theme: Theme {
        get {
            register(defaults: [#function: Theme.device.rawValue])
            return Theme(rawValue: integer(forKey: #function)) ?? .device
        }
        set {
            set(newValue.rawValue, forKey: #function)
        }
    }
    
    class func set(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func fetch(key: String) -> String? {
        if UserDefaults.standard.value(forKey: key) == nil {
            return nil
        } else {
            return  (UserDefaults.standard.value(forKey: key) as? String)
        }
    }
    
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}
