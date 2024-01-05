//
//  PasswordAccountService.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/22/23.
//

import UIKit
import SwiftyJSON
import Foundation

protocol PasswordAccountService {
    func checkAnEmail(email: String, completed: @escaping (Result<[UserModel]>) -> ())
    func resetPassword(userId: Int, params: [String: Any], completed: @escaping (Result<UserModel>) -> ())
    func changePassword(userId: Int, params: [String: Any], completed: @escaping (Result<JSON>) -> ())
}

class MockPasswordAccountService: PasswordAccountService {
    func checkAnEmail(email: String, completed: @escaping (Result<[UserModel]>) -> ()) {
        HttpRequest.get(.v1, endPoint: "looking-profile/\(email)") { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let userObj = try JSONDecoder().decode([UserModel].self, from: data!)
                    completed(Result.success(userObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func resetPassword(userId: Int, params: [String: Any], completed: @escaping (Result<UserModel>) -> ()) {
        HttpRequest.put(.v1, endPoint: "reset-password/\(userId)/", parameters: params) { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let userObj = try JSONDecoder().decode(UserModel.self, from: data!)
                    completed(Result.success(userObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func changePassword(userId: Int, params: [String: Any], completed: @escaping (Result<JSON>) -> ()) {
        HttpRequest.put(.v1, endPoint: "change-password/\(userId)/", headers: HttpHeader.apiToken(), parameters: params) { json, code, error in
            if error != nil {
                let jsonDict = JSON(json)
                if let oldPassword = jsonDict["old_password"]["old_password"].string {
                    completed(Result.failed(oldPassword))
                }
                if let password = jsonDict["password"][0].string {
                    completed(Result.failed(password))
                    return
                }
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let userObj = try JSONDecoder().decode(JSON.self, from: data!)
                    completed(Result.success(userObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
}
