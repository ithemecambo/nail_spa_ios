//
//  ApiResponseData.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/17/23.
//

import Foundation

struct ApiResponseData<T: Codable> {
    var status: Bool?
    var result: T?
    var message: ApiMessageData? 
}

struct ApiMessageData {
    var code: Int?           = 0
    var description: String? = ""
}
