//
//  AppointmentViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/23/23.
//

import Foundation

class AppointmentViewModel {
    
    private var mockService = MockAppointmentService()
    private var mockUserService = MockProfileService()
    
    func getAppointmentByWeekDays(_ keyword: String, completed: @escaping (Result<SectionAppointmentModel>) -> ()) {
        mockService.getAppointmentByWeekDays(keyword: keyword) { result in
            switch result {
            case .success(let data):
                completed(Result.success(data))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func getProfile(id: Int, completed: @escaping (Result<UserProfielModel>) -> ()) {
        mockUserService.profile(id: id) { result in
            switch result {
            case .success(let user):
                if user.count > 0 {
                    completed(Result.success(user[0]))
                }
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
}
