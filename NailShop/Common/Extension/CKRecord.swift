//
//  CKRecord.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/19/23.
//

import UIKit
import CloudKit
import Foundation

private let encoder: JSONEncoder = .init()
private let decoder: JSONDecoder = .init()

extension CKRecord {
    func decode<T>(forKey key: FieldKey) throws -> T where T: Decodable {
        guard let data = self[key] as? Data else {
            throw CocoaError(.coderValueNotFound)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
    func encode<T>(_ encodable: T, forKey key: FieldKey) throws where T: Encodable {
        self[key] = try encoder.encode(encodable)
    }
}
