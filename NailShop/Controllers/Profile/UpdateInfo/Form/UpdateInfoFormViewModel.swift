//
//  UpdateInfoFormViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/23/23.
//

import UIKit
import Foundation

class UpdateInfoFormViewModel {
    
    var profile: UserProfielModel?
    private var mockService = MockProfileService()
    
    required init(profile: UserProfielModel?) {
        self.profile = profile
    }
    
    func bindingView(_ view: UpdateInfoFormViewController) {
        guard let profile = profile else { return }
        profile.photoUrl == "" ? (view.profileImageView.image = UIImage(named: "avatar-profile")):
        (view.profileImageView.loadImage(url: "\(Configuration.baseUrl)\(profile.photoUrl ?? "")"))
        view.phoneTextField.text = profile.phone ?? ""
        view.addressTextField.text = profile.address ?? ""
        view.houseNoTextField.text = profile.houseNo ?? ""
        view.streetNoTextField.text = profile.streetNo ?? ""
        view.cityTextField.text = profile.city ?? ""
        view.stateTextField.text = profile.state ?? ""
        view.zipcodeTextField.text = profile.zipcode ?? ""
        view.bioTextArea.textView.text = profile.bio ?? ""
    }
    
    func updateInfoBody(_ view: UpdateInfoFormViewController) -> [String: Any] {
        var params: [String: Any] = [:]
        params["phone"] = view.phoneTextField.text ?? ""
        params["address"] = view.addressTextField.text ?? ""
        params["house_no"] = view.houseNoTextField.text ?? ""
        params["street_no"] = view.streetNoTextField.text ?? ""
        params["city"] = view.cityTextField.text ?? ""
        params["state"] = view.stateTextField.text ?? ""
        params["zipcode"] = view.zipcodeTextField.text ?? ""
        params["bio"] = view.bioTextArea.textView.text ?? ""
        
        return params
    }
    
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
    
    func updateInfo(profileId: Int, params: [String: Any], completed: @escaping (Result<String>) -> ()) {
        mockService.updateInfo(profileId: profileId, params: params) { result in
            switch result {
            case .success(let success):
                completed(Result.success(success))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func uploadAvatar(profileId: Int, params: [String: Any], imageData: Data, fileName: String, completed: @escaping (Result<String>) -> ()) {
        mockService.uploadAvatar(profileId: profileId, param: params, data: imageData, fileName: fileName) { result in
            switch result {
            case .success(let success):
                completed(Result.success(success))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
}
