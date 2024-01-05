//
//  ServiceModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/15/23.
//

import UIKit
import Foundation

struct ServiceModel: Codable {
    var id: Int?        = 0
    var parent: Int?    = 0
    var name: String?   = ""
    var price: CGFloat? = 0.0
    var symbol: String? = ""
    var photoUrl: String? = ""
    var description: String? = ""
    var isSelected: Bool? = false
    var children: [PackageModel]? = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case parent
        case name
        case price
        case symbol
        case photoUrl = "photo_url"
        case isSelected = "is_selected"
        case description
        case children
    }
}

struct PackageModel: Codable {
    var id: Int?        = 0
    var parent: Int?    = 0
    var name: String?   = ""
    var price: CGFloat? = 0.0
    var symbol: String? = ""
    var description: String? = ""
    var isSelected: Bool? = false
    var photoUrl: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case parent
        case name
        case price
        case symbol
        case description
        case isSelected = "is_selected"
        case photoUrl = "photo_url"
    }
}
