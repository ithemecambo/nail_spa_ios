//
//  ThreadHelper.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import Foundation

class ThreadHelper {
    
    static func delay(dalay: Double,handler: @escaping (() -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + dalay) {
            handler()
        }
    }
    
    static func runUI(updateUI: @escaping (()->Void)) {
        DispatchQueue.main.async {
            updateUI()
        }
    }
    
    static func runBackground(doBackground: @escaping (()->Void), updateUI: (()->Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            doBackground()
            DispatchQueue.main.async {
                updateUI?()
            }
        }
    }
    
    func uploadImageFeedBack(firstTask:(_ leaveTask:DispatchGroup) -> Void, completeAllTasks:@escaping () -> Void) {
        
        let groupTask = DispatchGroup()
        groupTask.enter()
        firstTask(groupTask)
        
        groupTask.notify(queue: DispatchQueue.main, execute: {
            completeAllTasks()
        })
    }
}
