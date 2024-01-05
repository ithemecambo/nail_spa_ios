//
//  SignInService.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import SwiftyJSON
import Foundation
import Alamofire

protocol SignInService {
    func createAccount(param: [String: Any], completed: @escaping (Result<UserModel>) -> ())
    func getAccount(userId: Int, completed: @escaping (Result<UserModel>) -> ())
    
    func createProfile(param: [String: Any], completed: @escaping (Result<CreateUserProfielModel>) -> ())
    func getProfile(userId: Int, completed: @escaping (Result<[UserProfielModel]>) -> ())
    
    func uploadAvatar(param: [String: Any], data: Data, fileName: String, completed: @escaping (Result<String>) -> ())
    
    func autoLogin(email: String?, password: String?, completed: @escaping (Result<LoginModel>) -> ())
}

class MockSignInService: SignInService {
    func createAccount(param: [String : Any], completed: @escaping (Result<UserModel>) -> ()) {
        HttpRequest.post(.v1, endPoint: "create-account/", parameters: param) { json, code, error in
            if error != nil {
                let jsonDict = JSON(json)
                if let errorEmail = jsonDict["email"].array {
                    completed(Result.failed(errorEmail[0].stringValue))
                    return
                }
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
    
    func getAccount(userId: Int, completed: @escaping (Result<UserModel>) -> ()) {
        HttpRequest.get(.v1, endPoint: "account/\(userId)/") { json, code, error in
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
    
    func createProfile(param: [String : Any], completed: @escaping (Result<CreateUserProfielModel>) -> ()) {
        HttpRequest.post(.v1, endPoint: "create-profile/", parameters: param) { json, code, error in
            if error != nil {
                let jsonDict = JSON(json)
                if let detail = jsonDict["detail"].string {
                    completed(Result.failed(detail))
                    return
                }
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let profileObj = try JSONDecoder().decode(CreateUserProfielModel.self, from: data!)
                    completed(Result.success(profileObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func getProfile(userId: Int, completed: @escaping (Result<[UserProfielModel]>) -> ()) {
        HttpRequest.get(.v1, endPoint: "profile/\(userId)/") { json, code, error in
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
    
    func uploadAvatar(param: [String: Any], data: Data, fileName: String, completed: @escaping (Result<String>) -> ()) {
        
        guard let url = URL(string: "\(Configuration.apiPath)create-profile/") else {
            return
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("multipart/form-data", forHTTPHeaderField: "Content-type")

        AF.upload(multipartFormData: { multiPart in
            for (key, value) in param {
                if let keyData = "\(value)".description.data(using: .utf8) {
                    multiPart.append(keyData, withName: key)
                }
            }
            multiPart.append(data, withName: "photo_url", fileName: fileName, mimeType: "image/*")
            consoleLog("param: \(multiPart)")
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            consoleLog("Upload Progress: \(progress.fractionCompleted)")
        })
        .response { response in
            consoleLog("upload \(response)")
            switch response.result {
               case .success(let data):
                consoleLog(data as Any)
                completed(Result.success("success"))
               case .failure(let error):
                completed(Result.failed(error.localizedDescription))
            }
        }
    }
    
    func autoLogin(email: String?, password: String?, completed: @escaping (Result<LoginModel>) -> ()) {
        guard let email = email, let password = password else {
            completed(Result.failed("Something was wrong."))
            return
        }
        let param: [String: Any] = ["username": email, "password": password]
        HttpRequest.post(.v1, endPoint: "login/", parameters: param) { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let loginObj = try JSONDecoder().decode(LoginModel.self, from: data!)
                    completed(Result.success(loginObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
}
