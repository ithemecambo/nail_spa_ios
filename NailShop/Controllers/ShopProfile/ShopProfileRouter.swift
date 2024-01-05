//
//  ShopProfileRouter.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import Foundation

enum ShopProfileSegue {
    case website
    case call
    case direction
    case share
}

protocol ShopProfileRouter {
    func perform(_ segue: ShopProfileSegue, from source: ShopProfileViewController)
}

class DefaultShopProfileRouter: ShopProfileRouter {
    func perform(_ segue: ShopProfileSegue, from source: ShopProfileViewController) {
        switch segue {
        case .website: break
        case .call: break
        case .direction: break
        case .share: break
        }
    }
}
