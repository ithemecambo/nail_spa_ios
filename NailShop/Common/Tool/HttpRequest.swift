//
//  HttpRequest.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/14/23.
//

import UIKit
import SwiftyJSON
import Alamofire

class HttpRequest {
    
    typealias RestResponse = ((_ response: JSON, _ responseCode: Int?, _ error: Error?) -> ())
    
    static func uploadImage(_ apiPathVer: ApiPathEnum = .v1,
                              endPoint: String,
                              headers: HTTPHeaders? = nil,
                              parameters: Parameters = [:],
                              data: Data,
                              withName name: String, 
                              completed: @escaping (Result<String>) -> ()) {
        
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in parameters {
                if let keyData = "\(value)".description.data(using: .utf8) {
                    multiPart.append(keyData, withName: key)
                }
            }
            multiPart.append(data, withName: "photo_url", fileName: name, mimeType: "image/jpeg")
            consoleLog("param: \(multiPart)")
        }, with: URLRequest(url: URL(string: endPoint)!))
        .uploadProgress(queue: .main, closure: { progress in
            
            consoleLog("Upload Progress: \(progress.fractionCompleted)")
        })
        .response { response in
            consoleLog("upload \(response)")
            switch response.result {
               case .success(let data):
                let successString = try? JSONDecoder().decode(String.self, from: data!)
                completed(Result.success(successString!))
               case .failure(let error):
                completed(Result.failed(error.localizedDescription))
            }
        }
    }
    
    static func get(_ apiPathVer: ApiPathEnum = .v1 ,endPoint: String, headers: HTTPHeaders? = nil, parameters: Parameters = [:], callback: @escaping RestResponse ) {
        
        var url = ""
        switch apiPathVer {
        case .v1:
            url = Configuration.apiPath + endPoint
        case .v2:
            url = Configuration.apiPath2 + endPoint
        }
        consoleLog("GET: endpoint ==== \(url)")
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding(), headers: headers)
            .validate()
            .responseString(encoding: .utf8) { (response: AFDataResponse<String>) in
                handle(response: response, responseCode: response.response?.statusCode, callback: callback)
            }
    }
    
    static func post(_ apiPathVer: ApiPathEnum = .v1 ,endPoint: String, headers: HTTPHeaders? = nil, parameters: Parameters = [:], callback: @escaping RestResponse) {
        var url = ""
        switch apiPathVer {
        case .v1:
            url = Configuration.apiPath + endPoint
        case .v2:
            url = Configuration.apiPath2 + endPoint
        }
        consoleLog("POST: endpoint ==== \(url)")
        consoleLog("Param: \(parameters)")
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseString(encoding: .utf8) { (response: AFDataResponse<String>) in
                handle(response: response, responseCode: response.response?.statusCode, callback: callback)
        }
    }
    
    static func put(_ apiPathVer: ApiPathEnum = .v1, endPoint: String, headers: HTTPHeaders? = nil, parameters: Parameters = [:], callback: @escaping RestResponse) {
        var url = ""
        switch apiPathVer {
        case .v1:
            url = Configuration.apiPath + endPoint
        case .v2:
            url = Configuration.apiPath2 + endPoint
        }
        consoleLog("PUT: endpoint ==== \(url)")
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseString(encoding: .utf8) { (response: AFDataResponse<String>) in
                handle(response: response, responseCode: response.response?.statusCode, callback: callback)
        }
    }
    
    static func delete(_ apiPathVer: ApiPathEnum = .v1, endPoint: String, headers: HTTPHeaders? = nil, parameters: Parameters = [:], callback: @escaping RestResponse) {
        var url = ""
        switch apiPathVer {
        case .v1:
            url = Configuration.apiPath + endPoint
        case .v2:
            url = Configuration.apiPath2 + endPoint
        }
        consoleLog("DELETE: endpoint ==== \(url)")
        AF.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseString(encoding: .utf8) { (response: AFDataResponse<String>) in
                handle(response: response, responseCode: response.response?.statusCode, callback: callback)
        }
    }
    
    private static func handle(response: AFDataResponse<String>, responseCode: Int?, callback: RestResponse) {
        guard let resultValue = response.value else {
            
            if let data = response.data, let json = try? JSON(data: data) {
                callback(json, responseCode, response.error)
            } else {
                callback(InternetConnectionManager.shared.isInternetConnected == false ? JSON(["message": "No internet connection."]) : JSON.null, responseCode, response.error)
            }
            return
        }
        let json = JSON(parseJSON: resultValue)
        callback(json, responseCode, response.error)
    }
}

extension URLEncoding {
    public func queryParameters(_ parameters: [String: Any]) -> [(String, String)] {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components
    }
}
