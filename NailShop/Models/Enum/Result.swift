//
//  Result.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import Foundation

enum Result<T: Codable> {
    case success(T)
    case failed(String)
}

enum ResultPaginator<T: Codable> {
    case success(T, Bool)
    case failed(String)
}
