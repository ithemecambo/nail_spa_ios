//
//  Date.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/18/23.
//

import Foundation

extension Date {
    func dateToStringFormat(_ stringFormat : String = "MMM dd, yyyy") -> String  {
        let formatter = DateFormatter()
        formatter.dateFormat = stringFormat
        formatter.locale =  Locale(identifier: "en")
        return formatter.string(from: self)
    }
    
    func dateToUTCFormat(_ stringFormat : String = "MMM dd, yyyy") -> String  {
        let formatter = DateFormatter()
        formatter.dateFormat = stringFormat
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: self)
    }
    

}
