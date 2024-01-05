//
//  CongrateAppointmentViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/5/23.
//

import UIKit
import Lottie

class CongrateAppointmentViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIView!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var goToMainView: UIView!
    
    private var router = DefaultCongrateAppointmentRouter()
    
    static func instantiate() -> CongrateAppointmentViewController {
        let controller = Appointment.instantiateViewController(withIdentifier: String(describing: self)) as! CongrateAppointmentViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.addSubview(LottieHandler.shared.initializeLottie(bounds: logoImageView.bounds, 
                                                                       fileName: "check-done"))
        LottieHandler.shared.playLoattieAnimation()
        ThreadHelper.delay(dalay: 1.5) {
            self.visibleView()
            self.setupAnimation()
        }
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func goToMainButtonTapped(_ sender: UIButton) {
        router.perform(.goMain, from: self)
    }
}

extension CongrateAppointmentViewController {
    fileprivate func setupAnimation() {
        let fromAnimation = AnimationType.from(direction: .random(), offset: 120)
        UIView.animate(views: [successLabel, lineView, messageLabel, goToMainView], animations: [fromAnimation], duration: 0.4)
    }
    
    fileprivate func visibleView() {
        successLabel.alpha = 1
        lineView.alpha = 1
        messageLabel.alpha = 1
        goToMainView.alpha = 1
    }
}
