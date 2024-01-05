//
//  HomeViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/21/23.
//

import Foundation

class HomeViewModel {
    
    private var mockService = MockNailSpaService()
    
    func getNailSpa(completed: @escaping (Result<HomeModel>) -> ()) {
        mockService.getNailSpa { result in
            switch result {
            case .success(let data):
                if data.count > 0 {
                    completed(Result.success(data[0]))
                } else {
                    completed(Result.failed("noResult"))
                }
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
}
