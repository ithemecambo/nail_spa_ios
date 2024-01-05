//
//  OurServiceInService.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/5/23.
//

import UIKit
import Foundation

protocol OurServiceInService {
    func getServices(completed: @escaping (Result<[ServiceModel]>) -> ())
}

class MockOurServiceInService: OurServiceInService {
    func getServices(completed: @escaping (Result<[ServiceModel]>) -> ()) {
        HttpRequest.get(.v1, endPoint: "getServices") { json, code, error in
            consoleLog("JSON: \(json.debugDescription)")
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let objc = try JSONDecoder().decode([ServiceModel].self, from: data!)
                    completed(Result.success(objc))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
}
