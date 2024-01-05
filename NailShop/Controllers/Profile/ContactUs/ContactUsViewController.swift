//
//  ContactUsViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController {
    
    @IBOutlet weak var mainOverView: UIView!
    @IBOutlet weak var bigOfficeTitleLabel: UILabel!
    @IBOutlet weak var smallOfficeTitleLabel: UILabel!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var directionIcon: UIImageView!
    @IBOutlet weak var facebookIcon: UIImageView!
    @IBOutlet weak var googleIcon: UIImageView!
    @IBOutlet weak var yelpIcon: UIImageView!
    
    static func instantiate() -> ContactUsViewController {
        let controller = Setting.instantiateViewController(withIdentifier: String(describing: self)) as! ContactUsViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAnimation
        title = "Nail & Spa Springs"
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        
        phoneIcon.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(phoneTapped(_:))))
        emailIcon.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(emailTapped(_:))))
        directionIcon.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(directionTapped(_:))))
        facebookIcon.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(facebookTapped(_:))))
        googleIcon.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(googleTapped(_:))))
        yelpIcon.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(yelpTapped(_:))))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
}

extension ContactUsViewController {
    fileprivate var setupAnimation: () {
        let fromAnimation = AnimationType.from(direction: .random(), offset: 100)
        UIView.animate(views: [mainOverView, bigOfficeTitleLabel, smallOfficeTitleLabel,
                               phoneIcon, emailIcon, directionIcon, facebookIcon,
                               googleIcon, yelpIcon], 
                       animations: [fromAnimation],
                       duration: 0.4)
    }
    
    @objc func phoneTapped(_ sender: UITapGestureRecognizer) {
        #if targetEnvironment(simulator)
            self.alertMessage(message: "Your device doesn't support call because you are using simulator.")
        #else
            dialNumber(number: "2708663389")
        #endif
    }
    
    @objc func emailTapped(_ sender: UITapGestureRecognizer) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["nailspasprings@gmail.com"])
            mail.setSubject("What is your purpose?")
            mail.setMessageBody("Type your message here...", isHTML: true)

            present(mail, animated: true)
        } else {
            self.alertMessage(message: "Your device doesn't support to send an email. Please try check it again.")
        }
    }
    
    @objc func directionTapped(_ sender: UITapGestureRecognizer) {
        self.contactUs("https://www.google.com/maps/dir/37.0835914,-85.2996486/Nail~Spa,+310+Steve+Dr+%235,+Russell+Springs,+KY+42642/@37.0511957,-85.3520555")
    }
    
    @objc func facebookTapped(_ sender: UITapGestureRecognizer) {
        self.contactUs("https://www.facebook.com/nailspaky")
    }
    
    @objc func googleTapped(_ sender: UITapGestureRecognizer) {
        self.contactUs("https://www.google.com/search?q=nail+spa+russell+springs+ky&oq=NAIL+SPA+RUSSELL+SPRINGS")
    }
    
    @objc func yelpTapped(_ sender: UITapGestureRecognizer) {
        self.contactUs("https://www.yelp.com/biz/nail-spa-russell-springs")
    }
}

extension ContactUsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            consoleLog("Cancelled")
        case .saved:
            consoleLog("Saved")
        case .sent:
            consoleLog("Sent")
        case .failed:
            consoleLog("Error: \(error!.localizedDescription)")
        default:
            break
        }
        controller.dismiss(animated: true)
    }
}
