//
//  LoginService.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import Foundation

protocol LoginService {
    func login(param: [String: Any], completed: @escaping (Result<LoginModel>) -> ())
    func getProfile(userId: Int, completed: @escaping (Result<[UserProfielModel]>) -> ())
    
    func checkAnEmail(email: String, completed: @escaping (Result<[UserModel]>) -> ())
}

class MockLoginService: LoginService {
    func login(param: [String : Any], completed: @escaping (Result<LoginModel>) -> ()) {
        HttpRequest.post(.v1, endPoint: "login/", parameters: param) { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let userObj = try JSONDecoder().decode(LoginModel.self, from: data!)
                    completed(Result.success(userObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func getProfile(userId: Int, completed: @escaping (Result<[UserProfielModel]>) -> ()) {
        HttpRequest.get(endPoint: "profile/\(userId)/") { json, code, error in
            consoleLog(json)
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let profileObj = try JSONDecoder().decode([UserProfielModel].self, from: data!)
                    completed(Result.success(profileObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func checkAnEmail(email: String, completed: @escaping (Result<[UserModel]>) -> ()) {
        HttpRequest.get(.v1, endPoint: "looking-profile/\(email)/") { json, code, error in
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
}
