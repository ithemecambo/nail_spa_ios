//
//  UploadImageType.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/14/23.
//

import Foundation

enum UploadImageType: String {
    case banners = "banners"
    case plans = "plans"
    case promotions = "promotions"
    case productBackground = "productBackground"
    case any = "any"
}

enum HomeType: String, Codable {
    case promotion
    case nail
    case service
    case gallery
    case business
}

enum ServiceType: String, Codable {
    case healthyNail
    case nailEnhancement
    case manicure
    case pedicure
    case additionalService
    
    var type: String {
        switch self {
        case .healthyNail:
            return "Healthy Nial"
        case .nailEnhancement:
            return "Nail Enhancement"
        case .manicure:
            return "Manicure"
        case .pedicure:
            return "Pedicure"
        case .additionalService:
            return "Additional Service"
        }
    }
}
