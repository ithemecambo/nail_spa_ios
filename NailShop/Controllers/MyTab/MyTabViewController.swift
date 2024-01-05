//
//  MyTabViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/17/23.
//

import UIKit

class MyTabViewController: UITabBarController {
    
    static func instantiate() -> MyTabViewController {
        let controller = Main.instantiateViewController(withIdentifier: String(describing: self)) as! MyTabViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarColor()
    }
    
    private func setupTabBarColor() {
        self.tabBar.backgroundColor = UIColor(named: "appColor")
        let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [MyTabViewController.self])
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.systemGreen], for: .selected)
    }
    
    private func setupTabBar() {
        let nailSpaTab = HomeViewController.instantiate()
        let nailSpaItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house"),
                                        selectedImage: UIImage(systemName: "house.circle.fill"))
        
        let appointmentTab = AppointmentViewController.instantiate()
        let appointmentItem = UITabBarItem(title: "Appointment",
                                        image: UIImage(systemName: "calendar"),
                                        selectedImage: UIImage(systemName: "calendar.circle.fill"))
        
        let myBookingTab = MyBookingViewController.instantiate()
        let myBookingItem = UITabBarItem(title: "My Booking",
                                            image: UIImage(systemName: "clock"),
                                            selectedImage: UIImage(systemName: "clock.circle.fill"))
        
        let accountTab = ProfileViewController.instantiate()
        let accountItem = UITabBarItem(title: "Profile",
                                       image: UIImage(systemName: "person"),
                                       selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        nailSpaTab.tabBarItem = nailSpaItem
        appointmentTab.tabBarItem = appointmentItem
        myBookingTab.tabBarItem = myBookingItem
        accountTab.tabBarItem = accountItem
        let tabBarList = [nailSpaTab, appointmentTab, myBookingTab, accountTab]
        self.viewControllers = tabBarList.map { UINavigationController(rootViewController: ($0 as UIViewController?)!) }
    }
}
