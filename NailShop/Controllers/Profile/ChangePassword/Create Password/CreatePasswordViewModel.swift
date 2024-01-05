//
//  CreatePasswordViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/26/23.
//

import UIKit
import Foundation

class CreatePasswordViewModel {
    
    var socialUser: SocialLoginModel?
    private var mockService = MockSignInService()
    
    required init(socialUser: SocialLoginModel?) {
        self.socialUser = socialUser
    }
    
    func createAccount(params: [String: Any], completed: @escaping (Result<UserModel>) -> ()) {
        mockService.createAccount(param: params) { result in
            switch result {
            case .success(let user):
                completed(Result.success(user))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func createProfile(params: [String: Any], data: Data, fileName: String, completed: @escaping (Result<String>) -> ()) {
        mockService.uploadAvatar(param: params, data: data, fileName: fileName) { result in
            switch result {
            case .success(_):
                completed(Result.success("success"))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func autoLogin(username: String, password: String, completed: @escaping (Result<LoginModel>) -> ()) {
        mockService.autoLogin(email: username, password: password) { result in
            switch result {
            case .success(let login):
                completed(Result.success(login))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func getProfile(userId: Int, completed: @escaping (Result<UserProfielModel>) -> ()) {
        mockService.getProfile(userId: userId) { result in
            switch result {
            case .success(let profile):
                if profile.count > 0 {
                    completed(Result.success(profile[0]))
                } else {
                    completed(Result.failed("Something was wrong [index out of an array]."))
                }
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func validation(newPassword: String?, confirmPassword: String?, completed: @escaping (Result<String>) -> ()) {
        guard let newPassword = newPassword, let confirmPassword = confirmPassword else {
            completed(Result.failed("Something was wrong."))
            return
        }
        
        if newPassword.isEmpty {
            completed(Result.failed("Please enter your new password."))
            return
        } else if confirmPassword.isEmpty {
            completed(Result.failed("Please enter a confirm password."))
            return
        } else {
            if newPassword != confirmPassword {
                completed(Result.failed("The passwords don't match. Please check it again!"))
                return
            }
            if newPassword.count < 8 || confirmPassword.count < 8 {
                completed(Result.failed("""
                                        This password is too short. It must contain at least 8 characters.
                                        This password is too common.
                                        This password is entirely numeric.
                                        """))
                return
            } else {
                completed(Result.success("Success"))
            }
        }
    }
    
    func accountBody(_ socialUser: SocialLoginModel?, from source: CreatePasswordViewController) -> [String: Any] {
        var params: [String: Any] = [:]
        params["first_name"] = socialUser?.givenName ?? ""
        params["last_name"] = socialUser?.familyName ?? ""
        params["email"] = socialUser?.email ?? ""
        params["password"] = source.newPasswordTextField.text ?? ""
        params["username"] = socialUser?.userId ?? ""
        params["is_active"] = true
        
        return params
    }
    
    func profileBody(_ user: UserModel?) -> [String: Any] {
        var params: [String: Any] = [:]
        params["user"] = user?.id ?? 0
        params["phone"] = ""
        params["address"] = ""
        params["bio"] = ""
        params["status"] = true
        
        return params
    }
}
