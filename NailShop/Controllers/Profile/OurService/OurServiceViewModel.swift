//
//  OurServiceViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/5/23.
//

import Foundation

class OurServiceViewModel {
    
    var source: String?
    private var service = MockOurServiceInService()
    
    required init(source: String?) {
        self.source = source
    }
    
    func getServices(completed: @escaping (Result<[ServiceModel]>) -> ()) {
        service.getServices { result in
            switch result {
            case .success(let data):
                completed(Result.success(data))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
}
