//
//  ForgetPasswordViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/28/23.
//

import UIKit
import MaterialComponents

class ForgetPasswordViewController: BaseViewController {
    
    @IBOutlet weak var newPasswordTextField: MDCOutlinedTextField!
    @IBOutlet weak var confirmPasswordTextField: MDCOutlinedTextField!
    @IBOutlet weak var layoutPasswordView: UIView!
    
    var viewModel: ForgetPasswordViewModel!
    private var router = DefaultForgetPasswordRouter()
    
    static func instantiate() -> ForgetPasswordViewController {
        let controller = Account.instantiateViewController(withIdentifier: String(describing: self)) as! ForgetPasswordViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupAnimation()
        title = "Forget Password"
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        viewModel.resetPassword(newPassword: self.newPasswordTextField.text ?? "",
            confirmPassword: self.confirmPasswordTextField.text ?? "") { result in
            self.startLoading(text: Loading)
            switch result {
            case .success(_):
                ThreadHelper.delay(dalay: 0.7) {
                    self.stopLoading()
                    self.router.perform(.done, from: self)
                }
            case .failed(let error):
                self.stopLoading()
                self.alertMessage(message: error)
            }
        }
    }
}

extension ForgetPasswordViewController {
    fileprivate func setupLayout() {
        newPasswordTextField.label.text = "New Password"
        newPasswordTextField.setOutlineColor(.systemGray, for: .normal)
        newPasswordTextField.setOutlineColor(.systemGreen, for: .editing)
        newPasswordTextField.leadingView = UIImageView(image: UIImage(systemName: "lock.circle.fill"))
        newPasswordTextField.leadingViewMode = .always
        
        let newPasswordButton = createButton(newPasswordTextField)
        newPasswordButton.tag = 1
        newPasswordButton.addTarget(self, action: #selector(showSecurePasswordTapped(_:)),
                                    for: .touchUpInside)
        
        newPasswordTextField.trailingView = newPasswordButton
        newPasswordTextField.trailingViewMode = .always
        
        confirmPasswordTextField.label.text = "Confirm Password"
        confirmPasswordTextField.setOutlineColor(.systemGray, for: .normal)
        confirmPasswordTextField.setOutlineColor(.systemGreen, for: .editing)
        confirmPasswordTextField.leadingView = UIImageView(image: UIImage(systemName: "lock.circle.fill"))
        
        confirmPasswordTextField.leadingViewMode = .always
        
        let confirmPasswordButton = createButton(newPasswordTextField)
        confirmPasswordButton.tag = 2
        confirmPasswordButton.addTarget(self, action: #selector(showSecurePasswordTapped(_:)),
                                    for: .touchUpInside)
        
        confirmPasswordTextField.trailingView = confirmPasswordButton
        confirmPasswordTextField.trailingViewMode = .always
    }
    
    fileprivate func setupAnimation() {
        let fromAnimation = AnimationType.from(direction: .left, offset: 100)
        UIView.animate(views: [newPasswordTextField, confirmPasswordTextField,
                               layoutPasswordView],
                       animations: [fromAnimation], duration: 0.4)
    }
    
    fileprivate func createButton(_ textField: MDCOutlinedTextField) -> UIButton {
        let passwordButton = UIButton(type: .custom)
        passwordButton.frame = CGRect(x: 0, y: 0,
                                      width: 24, height: CGFloat(textField.frame.height))
        passwordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        
        return passwordButton
    }
    
    @objc fileprivate func showSecurePasswordTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            sender.isSelected = !sender.isSelected
            newPasswordTextField.isSecureTextEntry = !sender.isSelected
        } else if sender.tag == 2 {
            sender.isSelected = !sender.isSelected
            confirmPasswordTextField.isSecureTextEntry = !sender.isSelected
        }
    }
}
