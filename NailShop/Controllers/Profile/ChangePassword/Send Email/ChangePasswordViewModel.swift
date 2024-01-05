//
//  ChangePasswordViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/14/23.
//

import Foundation

class ChangePasswordViewModel {
    
    var sourceType: String?
    private var mockService = MockPasswordAccountService()
    
    required init(sourceType: String) {
        self.sourceType = sourceType
    }
    
    func checkAnEmail(email: String?, completed: @escaping (Result<UserModel>) -> ()) {
        guard let email = email else {
            completed(Result.failed("Something was wrong."))
            return
        }
        if email.isEmpty {
            completed(Result.failed("Please enter your an email."))
            return
        } else {
            if !isValidateEmail(email) {
                completed(Result.failed("Your an email invalid. Please try to check again."))
                return
            }
            mockService.checkAnEmail(email: email) { result in
                switch result {
                case .success(let user):
                    if user.count > 0 {
                        completed(Result.success(user[0]))
                    } else {
                        completed(Result.failed("Something was wrong [index out of an array]."))
                    }
                case .failed(let error):
                    completed(Result.failed(error))
                }
            }
        }
    }
}
