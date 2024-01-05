//
//  LoginViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/23/23.
//

import Foundation
import SwiftyJSON
import GoogleSignIn
import FacebookCore
import FacebookLogin

class LoginViewModel {
    
    private var mockService = MockLoginService()

    func login(email: String?, password: String?, completed: @escaping (Result<String>) -> ()) {
        guard let email = email, let password = password else {
            completed(Result.failed("Something went wrong."))
            return
        }
        
        if email.isEmpty {
            completed(Result.failed("Please enter your an email address."))
            return
        } else if password.isEmpty {
            completed(Result.failed("Please enter your password."))
            return
        } else {
            var param = [String: Any]()
            param["username"] = email
            param["password"] = password
            mockService.login(param: param) { result in
                switch result {
                case .success(let data):
                    LoginModel.setUser(user: data)
                    completed(Result.success("success"))
                case .failed(let error):
                    completed(Result.failed(error))
                }
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
    
    func checkAnEmail(email: String, completed: @escaping (Result<UserModel>) -> ()) {
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
    
    func loginByGoogle(from source: LoginViewController, completed: @escaping (Result<SocialLoginModel>) -> ()) {
        GIDSignIn.sharedInstance.signIn(withPresenting: source) { signInResult, error in
            guard error == nil else {
                completed(Result.failed(error!.localizedDescription))
                return
            }
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            let socialUser = SocialLoginModel(userId: user.userID ?? "",
                                                name: user.profile?.name ?? "",
                                                givenName: user.profile?.givenName ?? "",
                                                familyName: user.profile?.familyName ?? "",
                                                email: user.profile?.email ?? "",
                                                photoUrl: profilePicUrl,
                                                photoPath: profilePicUrl?.lastPathComponent,
                                                accessToken: user.accessToken.tokenString
                                                )
            completed(Result.success(socialUser))
        }
    }
    
    func loginByFacebook(from source: LoginViewController, completed: @escaping (Result<SocialLoginModel>) -> ()) {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: source) { result in
            switch result {
            case .cancelled:
                completed(Result.failed("The user cancelled the sign-in flow of facebook login."))
            case .success(_, _, let accessToken):
                self.getFacebookUser { result in
                    switch result {
                    case .success(let user):
                        completed(Result.success(SocialLoginModel(userId: user.userId, name: "\(user.firstName ?? "") \(user.lastName ?? "")", givenName: user.firstName, familyName: user.lastName, email: user.email, photoUrl: user.photoUrl, photoPath: user.photoUrl?.lastPathComponent, accessToken: accessToken.tokenString)))
                    case .failed(let error):
                        completed(Result.failed(error))
                    }
                }
            case .failed(let error):
                completed(Result.failed(error.localizedDescription))
            }
        }
    }
    
    fileprivate func getFacebookUser(completed: @escaping (Result<FacebookModel>) -> ()) {
        guard AccessToken.current != nil else { 
            completed(Result.failed("The user doesn't permisson to access or login facebook. Please try to register instead of an email."))
            return }
        let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"])
        request.start() { connection, result, error in
            if let result = result, error == nil {
                let jsonUser = JSON(result)
                let userId = jsonUser["id"].string
                let firstName = jsonUser["first_name"].string
                let lastName = jsonUser["last_name"].string
                let email = jsonUser["email"].string
                let pictureUrl = jsonUser["picture"]["data"]["url"].string
                completed(Result.success(FacebookModel(userId: userId, firstName: firstName, lastName: lastName, email: email, photoUrl: URL(string: pictureUrl ?? ""))))
            } else {
                completed(Result.failed(error!.localizedDescription))
            }
        }
    }
}
