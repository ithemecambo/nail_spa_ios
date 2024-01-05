//
//  ChangePasswordViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit
import MaterialComponents

class ChangePasswordViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    @IBOutlet weak var layoutEmailView: UIView!
    
    var viewModel: ChangePasswordViewModel!
    private var router = DefaultSendEmailChangePasswordRouter()
    
    static func instantiate() -> ChangePasswordViewController {
        let controller = Account.instantiateViewController(withIdentifier: String(describing: self)) as! ChangePasswordViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        guard let viewModel = viewModel else { return }
        if viewModel.sourceType == "forget" {
            title = "Forget Password"
        } else {
            title = "Change Password"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        guard let viewModel = viewModel else { return }
        if viewModel.sourceType == "forget" {
            viewModel.checkAnEmail(email: self.emailTextField.text ?? "") { result in
                switch result {
                case .success(let user):
                    self.startLoading(text: Loading)
                    ThreadHelper.delay(dalay: 1.0) {
                        self.stopLoading()
                        self.router.perform(.resetPassword(user), from: self)
                    }
                case .failed(let error):
                    self.stopLoading()
                    self.alertMessage(message: error)
                }
            }
        } else {
            viewModel.checkAnEmail(email: self.emailTextField.text ?? "") { result in
                switch result {
                case .success(let user):
                    self.startLoading(text: Loading)
                    ThreadHelper.delay(dalay: 1.0) {
                        self.stopLoading()
                        self.router.perform(.changePassword(user), from: self)
                    }
                case .failed(let error):
                    self.stopLoading()
                    self.alertMessage(message: error)
                }
            }
        }
    }
}

extension ChangePasswordViewController {
    fileprivate func setupLayout() {
        emailTextField.label.text = "Email"
        emailTextField.setOutlineColor(.systemGray, for: .normal)
        emailTextField.setOutlineColor(.systemGreen, for: .editing)
        emailTextField.leadingView = UIImageView(image: UIImage(systemName: "envelope.circle.fill"))
        emailTextField.leadingViewMode = .always
    }
    
    fileprivate func setupAnimation() {
        let fromAnimation = AnimationType.from(direction: .left, offset: 100)
        UIView.animate(views: [emailTextField, layoutEmailView],
                       animations: [fromAnimation], duration: 0.4)
    }
}
