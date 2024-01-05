//
//  HttpHeader.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/14/23.
//

import UIKit
import Alamofire
import Foundation

struct HttpHeader {
    
    static func apiToken() -> HTTPHeaders {
        var params: HTTPHeaders = [:]
        params["Accept"] = "application/json"
        params["Content-Type"] = "application/json"
        guard let isLogin = LoginModel.getUser() else { return [:] }
        params["Authorization"] = "Token " + isLogin.token
        
        return params
    }
    
    static func tokenHeader() -> HTTPHeaders {
        let headers: HTTPHeaders = [
                    .contentType("application/json"),
                    .accept("application/json"),
                    .authorization("Token 618c8bb8b199ee279fefa2ee7f20f0e99ee1e52b")
                ]
        return headers
    }
    
    static func imageHeader() -> HTTPHeaders {
        var params: HTTPHeaders = [:]
        params["Accept"] = "application/json"
        params["Content-Type"] = "multipart/form-data"
        
        return params
    }
    
    static func apiHeader() -> [String: String] {
        
        var parameter = headerDefault()
        parameter["x-api-key"] = "eyJhbGciOiJIUzI1NiJ9.c2VhdGVsLWFwaS1kZXY.NsFhP0C7pqeONbcGAf42lQLLe6AIgy1QdOUOrg0uqcI"
        return parameter
    }
    
    static private func headerToken() -> [String: String] {
        var params: [String: String] = [:]
        params["accept"] = "application/json"
        params["Content-Type"] = "application/json"
        
        return params
    }
    
    static private func headerDefault() -> [String: String] {
        var parameter: [String: String] = [:]
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        parameter["X-UDID"] = UIDevice.current.identifierForVendor?.uuidString
        parameter["X-Platform"] = "ios"
        parameter["x-model"] = UIDevice.modelName
        parameter["X-OS-Version"] = UIDevice.current.systemVersion
        parameter["X-Timestamp"] = formatter.string(from: now)
        parameter["X-Timezone"] = NSTimeZone.local.identifier
        parameter["accept"] = "application/json"
        parameter["Content-Type"] = "application/json"
        parameter["X-App-Version"] = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "0.0.0"
        
        return parameter
    }
}
