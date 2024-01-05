//
//  NotificationViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import Foundation

class NotificationViewModel {
    private var mockService = MockNotificationService()
    
    func getNotifications(completed: @escaping (Result<[NotificationModel]>) -> ()) {
        mockService.getNotifications { result in
            switch result {
            case .success(let dataList):
                completed(Result.success(dataList.result))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func registerDevice(params: [String: Any], completed: @escaping (Result<DeviceModel>) -> ()) {
        mockService.registerDevice(params: params) { result in
            switch result {
            case .success(let device):
                completed(Result.success(device))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
}
