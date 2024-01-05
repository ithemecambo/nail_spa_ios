//
//  NotificationService.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/5/23.
//

import Foundation

protocol NotificationService {
    func getNotifications(completed: @escaping (Result<ApiNotificationModel>) -> ())
    func registerDevice(params: [String: Any], completed: @escaping (Result<DeviceModel>) -> ())
    func getDevices(completed: @escaping (Result<[DeviceModel]>) -> ())
}

class MockNotificationService: NotificationService {
    func getNotifications(completed: @escaping (Result<ApiNotificationModel>) -> ()) {
        HttpRequest.get(.v1, endPoint: "getNotifications") { json, code, error in
            
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let notification = try JSONDecoder().decode(ApiNotificationModel.self, from: data!)
                    completed(Result.success(notification))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func registerDevice(params: [String: Any], completed: @escaping (Result<DeviceModel>) -> ()) {
        HttpRequest.post(.v1, endPoint: "getPlatforms/", parameters: params) { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let deviceObj = try JSONDecoder().decode(DeviceModel.self, from: data!)
                    completed(Result.success(deviceObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func getDevices(completed: @escaping (Result<[DeviceModel]>) -> ()) {
        HttpRequest.get(.v1, endPoint: "getPlatforms/") { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let deviceObj = try JSONDecoder().decode([DeviceModel].self, from: data!)
                    completed(Result.success(deviceObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
}
