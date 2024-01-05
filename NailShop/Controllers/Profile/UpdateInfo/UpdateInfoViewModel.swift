//
//  UpdateInfoViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/23/23.
//

import UIKit
import Foundation

class UpdateInfoViewModel {
    
    private var mockService = MockProfileService()
    
    func profileInfo(userId: Int?, completed: @escaping (Result<UserProfielModel>) -> ()) {
        mockService.profile(id: userId ?? 0) { result in
            switch result {
            case .success(let users):
                if users.count > 0 {
                    completed(Result.success(users[0]))
                } else {
                    completed(Result.failed("Something was wrong [index out of an array]."))
                }
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func uploadAvatar(profileId: Int?, imageData: Data?, fileName: String?, completed: @escaping (Result<String>) -> ()) {
        mockService.uploadAvatar(profileId: profileId ?? 0, data: imageData, fileName: fileName) { result in
            switch result {
            case .success(let value):
                completed(Result.success(value))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
}
