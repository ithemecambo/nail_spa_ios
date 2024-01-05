//
//  UserModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import UIKit
import Foundation

struct CustomerModel: Codable {
    var id: UUID = UUID()
    var name: String?
    var avatar: String?
    var tel: String?
    var email: String?
    var bio: String?
    
    static var user: CustomerModel? {
        return CustomerModel(name: "Senghort Kheang", avatar: "login-logo", tel: "775-230-8584", email: "senghort.rupp@gmail.com", bio: "I'm really love coding.")
    }
}

struct LoginModel: Codable {
    var userId: Int        = 0
    var token: String      = ""
    var email: String      = ""
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case token
        case email
    }
    
    static func setUser(user: LoginModel) {
        UserDefaults.standard.set(object: user, forKey: "isLogin")
        UserDefaults.standard.synchronize()
    }
    
    static func getUser() -> LoginModel? {
        return UserDefaults.standard.object(LoginModel.self, with: "isLogin")
    }
    
    static func deleteUser() {
        UserDefaults.standard.removeObject(forKey: "isLogin")
        UserDefaults.standard.synchronize()
    }
}

struct CreateUserProfielModel: Codable {
    var id: Int?            = 0
    var user: Int?          = 0
    var phone: String?      = ""
    var bio: String?        = ""
    var address: String?    = ""
    var city: String?       = ""
    var state: String?      = ""
    var zipcode: String?    = ""
    var status: Bool?       = false
    var photoUrl: String?   = ""
}

struct UserModel: Codable {
    var id: Int?            = 0
    var firstName: String?  = ""
    var lastName: String?   = ""
    var username: String?   = ""
    var email: String?      = ""
    var dateJoined: String? = ""
    var createdDate: String? = ""
    var updatedDate: String? = ""
    var lastLogin: String?  = ""
    var isSupperUser: Bool? = false
    var isAdmin: Bool?      = false
    var isStaff: Bool?      = false
    var isActive: Bool?     =  false
    
    var fullName: String? {
        return "\(firstName ?? "") \(lastName ?? "")"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case email
        case dateJoined = "date_joined"
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case lastLogin = "last_login"
        case isSupperUser = "is_superuser"
        case isAdmin = "is_admin"
        case isStaff = "is_staff"
        case isActive = "is_active"
    }
}

struct UserProfielModel: Codable {
    var id: Int?            = 0
    var phone: String?      = ""
    var bio: String?        = ""
    var address: String?    = ""
    var houseNo: String?    = ""
    var streetNo: String?   = ""
    var city: String?       = ""
    var state: String?      = ""
    var zipcode: String?    = ""
    var status: Bool?       = false
    var photoUrl: String?   = ""
    var user: UserModel?    = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case phone
        case bio
        case address
        case houseNo = "house_no"
        case streetNo = "street_no"
        case city
        case state
        case zipcode
        case status
        case photoUrl = "photo_url"
        case user
    }
    
    static func setProfile(_ profile: UserProfielModel) {
        UserDefaults.standard.set(object: profile, forKey: "profile")
        UserDefaults.standard.synchronize()
    }
    
    static func getProfile() -> UserProfielModel? {
        return UserDefaults.standard.object(UserProfielModel.self, with: "profile")
    }
    
    static func deleteProfile() {
        UserDefaults.standard.removeObject(forKey: "profile")
        UserDefaults.standard.synchronize()
    }
}

struct StaffMemberModel: Codable {
    var id: Int?            = 0
    var nickName: String?   = ""
    var fax: String?        = ""
    var socailSecurityNumber: String? = ""
    var licenseNo: String?  = ""
    var expirationDate: String? = ""
    var address: String?    = ""
    var status: Bool?       = false
    var photoUrl: String?   = ""
    var user: UserModel?    = nil
    var color: String?      = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case nickName = "nickname"
        case fax
        case socailSecurityNumber = "ssn"
        case licenseNo = "license_no"
        case expirationDate = "expiration_date"
        case address
        case status
        case photoUrl = "photo_url"
        case user
        case color
    }
}

struct ProfileInfo: Codable {
    var icon: String
    var key: String
    var value: String
}

struct SocialLoginModel: Codable {
    var userId: String?     = ""
    var name: String?       = ""
    var givenName: String?  = ""
    var familyName: String? = ""
    var email: String?      = ""
    var photoUrl: URL?
    var photoPath: String?  = ""
    var accessToken: String? = ""
}

struct FacebookModel: Codable {
    var userId: String?     = ""
    var name: String?       = ""
    var firstName: String?  = ""
    var lastName: String?   = ""
    var email: String?      = ""
    var photoUrl: URL?     = URL(string: "")
}
