//
//  AboutUsViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit
import MapKit
import MessageUI

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var officeNameLabel: UILabel!
    @IBOutlet weak var officeAddressLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var customerSupportLabel: UILabel!
    @IBOutlet weak var officeTelLabel: UILabel!
    @IBOutlet weak var officeEmailLabel: UILabel!
    @IBOutlet weak var websiteIcon: UIImageView!
    @IBOutlet weak var officeTelIcon: UIImageView!
    @IBOutlet weak var officeEmailIcon: UIImageView!
    @IBOutlet weak var contactConstraintHeight: NSLayoutConstraint!
    
    static func instantiate() -> AboutUsViewController {
        let controller = Setting.instantiateViewController(withIdentifier: String(describing: self)) as! AboutUsViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapUI()
        self.setupAnimation()
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        contactConstraintHeight.constant = (UIScreen.main.bounds.height >= 812 ? 220: 235)
        websiteLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(websiteTapped(_:))))
        officeTelLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(telTapped(_:))))
        officeEmailLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(emailTapped(_:))))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
}

extension AboutUsViewController {
    fileprivate func setupMapUI() {
        mapView.delegate = self
        title = "Nail & Spa Springs"
        let initialCoordinate = CLLocationCoordinate2DMake(37.084765, -85.3008273)
        let initialregion = MKCoordinateRegion(center: initialCoordinate,
                                               span: MKCoordinateSpan(latitudeDelta: 0.25,
                                                                      longitudeDelta: 0.25))
        mapView.setRegion(initialregion, animated: true)
        let carAddress = StoreAnnotation(37.084765,
                                       longitude: -85.3008273,
                                       title: "Nail & Spa Springs",
                                       subtitle: "310 Steve Dr Ste #5, Russell Springs, KY 42642")
        mapView.addAnnotation(carAddress)
        mapView.selectAnnotation(carAddress, animated: true)
    }
    
    fileprivate func setupAnimation() {
        let fromAnimation = AnimationType.from(direction: .left, offset: 100)
        UIView.animate(views: [mapView, officeNameLabel, officeAddressLabel, websiteIcon,
                               websiteLabel, customerSupportLabel, officeTelIcon, officeTelLabel,
                               officeEmailIcon, officeEmailLabel],
                       animations: [fromAnimation],
                       duration: 0.4)
    }
    
    @objc func websiteTapped(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "http://nailsparussellsprings.com") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc func telTapped(_ sender: UITapGestureRecognizer) {
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
}

extension AboutUsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? StoreAnnotation else {return nil}
        let identifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.tintColor = .colorApp
        annotationView?.canShowCallout = true
        
        return annotationView
    }
}

extension AboutUsViewController: MFMailComposeViewControllerDelegate {
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
