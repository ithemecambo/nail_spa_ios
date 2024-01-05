//
//  ForgetPasswordViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/14/23.
//

import Foundation

class ForgetPasswordViewModel {
    
    var user: UserModel?
    private var mockService = MockPasswordAccountService()
    
    required init(user: UserModel?) {
        self.user = user
    }
    
    func resetPassword(newPassword: String?, confirmPassword: String?, completed: @escaping (Result<UserModel>) -> ()) {
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
                guard let user = user else { return }
                let params: [String: Any] = ["email": user.email ?? "", "password": newPassword]
                mockService.resetPassword(userId: user.id ?? 0, params: params) { result in
                    switch result {
                    case .success(let user):
                        completed(Result.success(user))
                    case .failed(let error):
                        completed(Result.failed(error))
                    }
                }
            }
        }
    }
}
