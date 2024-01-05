//
//  SignInViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/23/23.
//

import Foundation

class SignInViewModel {
    
    private var mockService = MockSignInService()
    
    func valid(firstName: String?, lastName: String?, tel: String?, address: String?, email: String?, password: String?, completed: @escaping (Result<String>) -> ()) {
        guard let firstName = firstName, let lastName = lastName, let tel = tel, let address = address, let email = email, let password = password else {
            completed(Result.failed("Something was wrong."))
            return
        }
        if firstName.isEmpty {
            completed(Result.failed("Please enter your give name."))
            return
        } else if lastName.isEmpty {
            completed(Result.failed("Please enter your family name."))
            return
        } else if tel.isEmpty {
            completed(Result.failed("Please enter your phone number."))
            return
        } else if address.isEmpty {
            completed(Result.failed("Please enter your address."))
            return
        } else if email.isEmpty {
            completed(Result.failed("Please enter your email."))
            return
        }
        else if password.isEmpty {
            completed(Result.failed("Please enter your password."))
            return
        } else {
            if !isValidateEmail(email) {
                completed(Result.failed("Your an email invalid. Please try to check again."))
                return
            }
            if password.count < 8 {
                completed(Result.failed("""
                                        This password is too short. It must contain at least 8 characters.
                                        This password is too common.
                                        This password is entirely numeric.
                                        """))
                return
            }
            completed(Result.success("success"))
        }
    }
    
    func bodyAccount(_ controller: SignInViewController) -> [String: Any] {
        var param: [String: Any] = [:]
        param["first_name"] = controller.firstNameTextField.text ?? ""
        param["last_name"] = controller.lastNameTextField.text ?? ""
        param["email"] = controller.emailTextField.text ?? ""
        param["password"] = controller.passwordTextField.text ?? ""
        param["username"] = controller.firstNameTextField.text?.lowercased() ?? ""
        param["is_active"] = true
        
        return param
    }
    
    func bodyUserProfile(_ account: UserModel?, from controller: SignInViewController) -> [String: Any] {
        var param: [String: Any] = [:]
        param["user"] = account?.id ?? 0
        param["phone"] = controller.telTextField.text ?? ""
        param["address"] = controller.addressTextField.text ?? ""
        param["bio"] = controller.bioTextArea.textView.text ?? ""
        param["status"] = true
        
        return param
    }
    
    func createAccount(param: [String: Any], completed: @escaping (Result<UserModel>) -> ()) {
        mockService.createAccount(param: param) { result in
            switch result {
            case .success(let user):
                completed(Result.success(user))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func createProfile(param: [String: Any], completed: @escaping (Result<CreateUserProfielModel>) -> ()) {
        mockService.createProfile(param: param) { result in
            switch result {
            case .success(let profile):
                completed(Result.success(profile))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func uploadAvatar(param: [String: Any], data: Data, fileName: String, completed: @escaping (Result<String>) -> ()) {
        mockService.uploadAvatar(param: param, data: data, fileName: fileName) { result in
            switch result {
            case .success(_):
                completed(Result.success("success"))
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
    
}
