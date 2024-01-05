//
//  CoreDataManager.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/13/23.
//

import UIKit
import CoreData
import Foundation

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    fileprivate let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NailShop")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Fatal error loading container: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    fileprivate func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Save error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func savePackage(id: Int, parent: Int, name: String, price: CGFloat, symbol: String, photoUrl: String, description: String, isSelected: Bool) {
        let package = CDPackage(context: persistentContainer.viewContext)
        package.id = Int16(id)
        package.parent = Int16(parent)
        package.name = name
        package.price = Float(price)
        package.symbol = symbol
        package.photoUrl = photoUrl
        package.desc = description
        package.isSelected = isSelected
        saveContext()
    }
    
    func saveService(id: Int, parent: Int, name: String, price: CGFloat, symbol: String, photoUrl: String, description: String, isSelected: Bool) {
        let service = CDService(context: persistentContainer.viewContext)
        service.id = Int16(id)
        service.parent = Int16(parent)
        service.name = name
        service.price = Float(price)
        service.symbol = symbol
        service.photoUrl = photoUrl
        service.desc = description
        service.isSelected = isSelected
        saveContext()
    }
    
    func updatePackage(id: Int16, isSelected: Bool) {
        let request: NSFetchRequest<CDPackage> = CDPackage.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            let packages = try persistentContainer.viewContext.fetch(request)
            if packages.count > 0 {
                packages[0].isSelected = isSelected
                self.saveContext()
            }
        } catch let error {
            consoleLog(error.localizedDescription)
        }
    }
    
    func fetchPackages() -> [CDPackage] {
        let request: NSFetchRequest<CDPackage> = CDPackage.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        var packages: [CDPackage] = []
        do {
            packages = try persistentContainer.viewContext.fetch(request)
            
        } catch let error {
            consoleLog("Fetch Error: \(error.localizedDescription)")
        }
        return packages
    }
    
    func fetchServices() -> [CDService] {
        let request: NSFetchRequest<CDService> = CDService.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        var services: [CDService] = []
        do {
            services = try persistentContainer.viewContext.fetch(request)
            
        } catch let error {
            consoleLog("Fetch Error: \(error.localizedDescription)")
        }
        return services
    }
    
    
    fileprivate func deletePackage() {
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CDPackage")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try persistentContainer.viewContext.execute(batchDeleteRequest)
        } catch let error {
            consoleLog("Delete Error: \(error.localizedDescription)")
        }
    }
    
    fileprivate func deleteService() {
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CDService")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try persistentContainer.viewContext.execute(batchDeleteRequest)
        } catch let error {
            consoleLog("Delete Error: \(error.localizedDescription)")
        }
    }
    
    func delete() {
        self.deleteService()
        self.deletePackage()
        UserDefaults.standard.set(false, forKey: UserDefaults.Keys.savedInLocal)
        UserDefaults.standard.synchronize()
    }
}
