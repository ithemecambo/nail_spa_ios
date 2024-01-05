//
//  UserProfileTests.swift
//  NailShopTests
//
//  Created by SENGHORT KHEANG on 12/28/23.
//

import XCTest
@testable import NailShop

final class UserProfileTests: XCTestCase {
    
    private var viewModel = LoginViewModel()
    private var loginUser = LoginModel.getUser()
    private var profileUser = UserProfielModel()
    
    
    func testUserLoginSuccess() {
        viewModel.login(email: "user7@gmail.com", password: "Zaq12345!!") { result in
            switch result {
            case .success(let user):
                XCTAssertTrue(!user.isEmpty)
                XCTAssertEqual(user.count, 1)
            case .failed(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func testUserLoginWrongEmailPassword() {
        viewModel.login(email: "user8@gmail.com", password: "Zaq12345") { result in
            switch result {
            case .success(let user):
                XCTAssertNil(user)
            case .failed(let error):
                XCTAssertEqual(error, "Invalid email and/or password. Please try again!")
            }
        }
    }
    
    func testLoginAsNoneNormalUser() {
        viewModel.login(email: "tith.chhorn@gmail.com", password: "Zaq12345@@") { result in
            switch result {
            case .success(let user):
                XCTAssertNil(user)
            case .failed(let error):
                XCTAssertEqual(error, "The user doesn't permisson to access or login facebook. Please try to register instead of an email.")
            }
        }
    }
    
    func testGetUserProfileSuccess() {
        viewModel.getProfile(userId: loginUser?.userId ?? 0) { result in
            switch result {
            case .success(let profile):
                self.profileUser = profile
                debugPrint(profile)
                XCTAssertNotNil(profile)
            case .failed(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func testCheckExistingAnEmail() {
        viewModel.checkAnEmail(email: "user8.app@gmail.co") { result in
            switch result {
            case .success(let user):
                XCTAssertNil(user)
            case .failed(let error):
                XCTAssertNil(error)
            }
        }
    }
}
