//
//  Array.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/21/23.
//

import Foundation

extension Array {
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
