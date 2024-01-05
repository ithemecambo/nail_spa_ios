//
//  BaseViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {

    private var size = CGSize(width: 30, height: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseListenNotification
        baseConfigDidLoad
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private var baseConfigDidLoad: () {
        if !InternetConnectionManager.shared.isInternetConnected {
            self.restorationIdentifier = "need to reload"
        }
    }
    
    private var baseListenNotification: () {
        updateInternetConnection
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged(_:)),
                                               name: ReachabilityChangedNotification,
                                               object: nil)
    }
    
    @objc func reachabilityChanged(_ notification: Notification) {
        updateInternetConnection
    }
    
    private var updateInternetConnection: () {
        if InternetConnectionManager.shared.isInternetConnected {
            InternetConnectionManager.shared.removeViewInternet(view: self.view)
            
            if let _ = self.restorationIdentifier {
                self.restorationIdentifier = nil
                viewDidLoad()
            }
        } else {
            InternetConnectionManager.shared.addViewInternet(view: self.view)
        }
    }
}

extension BaseViewController: NVActivityIndicatorViewable {
    func startTextLoading(messageLoading: String, finish messageFinish: String) {
        startAnimating(size, message: messageLoading,
                       type: NVActivityIndicatorType.ballClipRotate,
                       fadeInAnimation: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage(messageFinish)
        }
    }

    func startLoading(text messageLoading: String = "") {
        startAnimating(size, message: messageLoading,
                       type: NVActivityIndicatorType.ballClipRotate,
                       fadeInAnimation: nil)
    }
    
    func stopLoading() {
        stopAnimating(nil)
    }
}
