//
//  SheetServiceViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/11/23.
//

import Foundation

class SheetServiceViewModel {
    
    var services: [PackageModel]?
    private var mockService = MockOurServiceInService()
    
    required init(services: [PackageModel]?) {
        self.services = services
    }
    
    func getServices(completed: @escaping (Result<[ServiceModel]>) -> ()) {
        mockService.getServices { result in
            switch result {
            case .success(let data):
                completed(Result.success(data))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func selectedPackages() -> [PackageModel] {
        var servicePackages: [PackageModel] = []
        let resultPackages = CoreDataManager.shared.fetchPackages().filter({ item in
            item.isSelected
        })
        if !resultPackages.isEmpty {
            resultPackages.forEach({ p in
                servicePackages.append(PackageModel(id: Int(p.id), parent: Int(p.parent), name: p.name, price: CGFloat(p.price), symbol: p.symbol, description: p.desc, isSelected: p.isSelected, photoUrl: p.photoUrl))
            })
        }
        return servicePackages
    }
    
    func getServiceData(completed: @escaping (Result<[ServiceModel]>) -> ()) {
        var serviceDatas: [ServiceModel] = []
        if CoreDataManager.shared.fetchServices().count > 0 &&
            CoreDataManager.shared.fetchPackages().count > 0 {
            CoreDataManager.shared.fetchServices().forEach { service in
                var children: [PackageModel] = []
                CoreDataManager.shared.fetchPackages().forEach { package in
                    if service.id == package.parent {
                        children.append(PackageModel(id: Int(package.id), parent: Int(package.parent), name: package.name, price: CGFloat(package.price), symbol: package.symbol, description: package.desc, isSelected: package.isSelected, photoUrl: package.photoUrl))
                    }
                }
                serviceDatas.append(ServiceModel(id: Int(service.id), parent: Int(service.parent), name: service.name, price: CGFloat(service.price), symbol: service.symbol, photoUrl: service.photoUrl, description: service.desc, isSelected: service.isSelected, children: children))
            }
            completed(Result.success(serviceDatas))
        } else {
            completed(Result.failed("Could not download data from local."))
        }
    }
    
    func saveServiceData(services: [ServiceModel], completed: @escaping (Result<[ServiceModel]>) -> ()) {
        if services.count > 0 {
            services.forEach { service in
                CoreDataManager.shared.saveService(id: service.id ?? 0, parent: service.parent ?? 0, name: service.name ?? "", price: service.price ?? 0.0, symbol: service.symbol ?? "", photoUrl: service.photoUrl ?? "", description: service.description ?? "", isSelected: service.isSelected ?? false)
                if service.children?.count ?? 0 > 0 {
                    service.children?.forEach({ package in
                        CoreDataManager.shared.savePackage(id: package.id ?? 0, parent: package.parent ?? 0, name: package.name ?? "", price: package.price ?? 0.0, symbol: package.symbol ?? "", photoUrl: package.photoUrl ?? "", description: package.description ?? "", isSelected: package.isSelected ?? false)
                    })
                }
            }
            completed(Result.success(services))
        } else {
            completed(Result.failed("Could not load data from server."))
        }
    }
}
