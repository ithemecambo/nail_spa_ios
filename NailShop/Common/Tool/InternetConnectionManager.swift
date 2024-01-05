//
//  InternetConnectionManager.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import Foundation

class InternetConnectionManager {
    
    var windowScene = UIApplication.shared.connectedScenes.first
    static let shared = InternetConnectionManager()
    let reachability = Reachability()!
    
    init() {
        do {
            try reachability.startNotifier()
        } catch {
            consoleLog("could not start reachability notifier")
        }
    }
    
    var isInternetConnected: Bool {
        let networkStatus = reachability.currentReachabilityStatus
        let isConnect = networkStatus != .notReachable
        return isConnect
    }
    
    struct ConstBase {
        static let tagViewInternet = 987
        static let tagLabelInternet = 789
    }
    
    func addViewInternet(view: UIView) {
        
        let coordinateY = view.frame.size.height
        let viewMainInternet = view.viewWithTag(ConstBase.tagViewInternet) ?? {
            let internetStatusLabel = UILabel(frame: CGRect(x: 0,
                                                            y: UIDevice.isiPhoneX ? 5:0,
                                                            width: UIScreen.width,
                                                            height: 30))
            let viewTemp = UIView(frame: CGRect(x: 0, y: coordinateY,
                                                width: UIScreen.width,
                                                height: UIDevice.isiPhoneX ? 40:30))
            internetStatusLabel.textAlignment = .center
            internetStatusLabel.font = UIFont.systemFont(ofSize: 13)
            internetStatusLabel.textColor = UIColor.white
            internetStatusLabel.tag = ConstBase.tagLabelInternet
            internetStatusLabel.backgroundColor = .clear
            internetStatusLabel.alpha = 0.9
            viewTemp.tag = ConstBase.tagViewInternet
            viewTemp.addSubview(internetStatusLabel)
            view.addSubview(viewTemp)
            return viewTemp
            
            }()
        
//        viewMainInternet.backgroundColor = UIColor(red: 248/255.0,
//                                                   green: 147/255.0,
//                                                   blue: 31/255.0,
//                                                   alpha: 0.3)
        
        viewMainInternet.backgroundColor = .clear
        if let internetStatusLabel = viewMainInternet.viewWithTag(ConstBase.tagLabelInternet) as? UILabel {
            internetStatusLabel.font = .boldSystemFont(ofSize: 15)
            internetStatusLabel.text = "No Internet Connection"
            internetStatusLabel.textColor = UIColor(named: "textColor")
        }
        
        ThreadHelper.delay(dalay: 0.5) {
//            UIView.animate(withDuration: 0.4, animations: {
                viewMainInternet.frame.origin.y = UIDevice.isiPhoneX ? 100 : 64
//                if let appDelegate = self.windowScene?.delegate as? SceneDelegate {
//                    if (appDelegate.window?.rootViewController as? UITabBarController) != nil {
//                        viewMainInternet.frame.origin.y = coordinateY - viewMainInternet.frame.size.height - (UIScreen.main.bounds.height >= 812 ? 73: 48)
//                    } else if (appDelegate.window?.rootViewController as? UINavigationController) != nil {
//                        viewMainInternet.frame.origin.y = coordinateY - viewMainInternet.frame.size.height
//                    } else {
//                        viewMainInternet.frame.origin.y = coordinateY - viewMainInternet.frame.size.height
//                    }
//                }
                //viewMainInternet.frame.origin.y = coordinateY - viewMainInternet.frame.size.height
//            })
        }
    }
    
    func removeViewInternet(view: UIView) {
        if Thread.isMainThread {
            removeView(view: view)
        } else {
            ThreadHelper.runUI {
                self.removeView(view: view)
            }
        }
    }
    
    private func removeView(view: UIView) {
        if let viewMainInternet = view.viewWithTag(ConstBase.tagViewInternet) {
            
            //let coordinateY = view.frame.size.height
            if let internetStatusLabel = viewMainInternet.viewWithTag(ConstBase.tagLabelInternet) as? UILabel {
                internetStatusLabel.text = "Connected"
                internetStatusLabel.font = .boldSystemFont(ofSize: 15)
                internetStatusLabel.textColor = UIColor(named: "textColor")
            }
            
            viewMainInternet.backgroundColor = UIColor(rgb: 0xe4fce1e)
            UIView.animate(withDuration: 0.4,
                           delay: 1,
                           animations: {
                            viewMainInternet.frame.origin.y = -(UIDevice.isiPhoneX ? 150 : 100)
                            //coordinateY + (UIDevice.isiPhoneX ? 40 : 30)
            })
        }
    }
}


