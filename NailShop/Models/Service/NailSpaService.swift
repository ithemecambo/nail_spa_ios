//
//  NailSpaService.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import Foundation

protocol NailSpaService {
    func getNailSpa(completed: @escaping (Result<[HomeModel]>) -> ())
}

class MockNailSpaService: NailSpaService {
    func getNailSpa(completed: @escaping (Result<[HomeModel]>) -> ()) {
        HttpRequest.get(.v1, endPoint: "getNailSpa") { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let objc = try JSONDecoder().decode([HomeModel].self, from: data!)
                    completed(Result.success(objc))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
}
