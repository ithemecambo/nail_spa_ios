//
//  ProfileService.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import Alamofire
import SwiftyJSON
import Foundation

protocol ProfileService {
    func profile(id: Int, completed: @escaping (Result<[UserProfielModel]>) -> ())
    func updateInfo(profileId: Int, params: [String: Any], completed: @escaping (Result<String>) -> ())
    func uploadAvatar(profileId: Int, param: [String: Any], data: Data?, fileName: String?, completed: @escaping (Result<String>) -> ())
}

class MockProfileService: ProfileService {
    func profile(id: Int, completed: @escaping (Result<[UserProfielModel]>) -> ()) {
        HttpRequest.get(.v1, endPoint: "profile/\(id)/") { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let userObj = try JSONDecoder().decode([UserProfielModel].self, from: data!)
                    completed(Result.success(userObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func updateInfo(profileId: Int, params: [String: Any], completed: @escaping (Result<String>) -> ()) {
        HttpRequest.put(.v1, endPoint: "update-profile/\(profileId)/") { json, code, error in
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
                    let userObj = try JSONDecoder().decode(String.self, from: data!)
                    completed(Result.success(userObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func uploadAvatar(profileId: Int, param: [String: Any] = [:], data: Data?, fileName: String?, completed: @escaping (Result<String>) -> ()) {
        guard let url = URL(string: "\(Configuration.apiPath)update-profile/\(profileId)/") else {
            return
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("multipart/form-data", forHTTPHeaderField: "Content-type")

        AF.upload(multipartFormData: { multiPart in
            for (key, value) in param {
                if let keyData = "\(value)".description.data(using: .utf8) {
                    multiPart.append(keyData, withName: key)
                }
            }
            multiPart.append(data!, withName: "photo_url", fileName: fileName, mimeType: "image/*")
            consoleLog("param: \(multiPart)")
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            consoleLog("Upload Progress: \(progress.fractionCompleted)")
        })
        .response { response in
            consoleLog("upload \(response)")
            switch response.result {
               case .success(_):
                completed(Result.success("success"))
               case .failure(let error):
                completed(Result.failed(error.localizedDescription))
            }
        }
    }
}
