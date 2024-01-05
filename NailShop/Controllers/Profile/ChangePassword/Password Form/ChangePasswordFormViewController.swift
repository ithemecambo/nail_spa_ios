//
//  ChangePasswordFormViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/14/23.
//

import UIKit
import MaterialComponents

class ChangePasswordFormViewController: BaseViewController {

    @IBOutlet weak var oldPasswordTextField: MDCOutlinedTextField!
    @IBOutlet weak var newPasswordTextField: MDCOutlinedTextField!
    @IBOutlet weak var confirmPasswordTextField: MDCOutlinedTextField!
    @IBOutlet weak var layoutPasswordView: UIView!
    
    var viewModel: ChangePasswordFormViewModel!
    private var router = DefaultChangePasswordFormRouter()
    
    static func instantiate() -> ChangePasswordFormViewController {
        let controller = Account.instantiateViewController(withIdentifier: String(describing: self)) as! ChangePasswordFormViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupAnimation()
        title = "Change Password"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        viewModel.changePassword(oldPassword: oldPasswordTextField.text ?? "", 
                                 newPassword: newPasswordTextField.text ?? "",
                                 confirmPassword: confirmPasswordTextField.text ?? "") { result in
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

extension ChangePasswordFormViewController {
    fileprivate func setupLayout() {
        oldPasswordTextField.label.text = "Old Password"
        oldPasswordTextField.setOutlineColor(.systemGray, for: .normal)
        oldPasswordTextField.setOutlineColor(.systemGreen, for: .editing)
        oldPasswordTextField.leadingView = UIImageView(image: UIImage(systemName: "lock.circle.fill"))
        oldPasswordTextField.leadingViewMode = .always
        
        let oldPasswordButton = createButton(oldPasswordTextField)
        oldPasswordButton.tag = 1
        oldPasswordButton.addTarget(self, action: #selector(showSecurePasswordTapped(_:)),
                                 for: .touchUpInside)
        
        oldPasswordTextField.trailingView = oldPasswordButton
        oldPasswordTextField.trailingViewMode = .always
        
        newPasswordTextField.label.text = "New Password"
        newPasswordTextField.setOutlineColor(.systemGray, for: .normal)
        newPasswordTextField.setOutlineColor(.systemGreen, for: .editing)
        newPasswordTextField.leadingView = UIImageView(image: UIImage(systemName: "lock.circle.fill"))
        newPasswordTextField.leadingViewMode = .always
        
        let newPasswordButton = createButton(newPasswordTextField)
        newPasswordButton.tag = 2
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
        confirmPasswordButton.tag = 3
        confirmPasswordButton.addTarget(self, action: #selector(showSecurePasswordTapped(_:)),
                                    for: .touchUpInside)
        
        confirmPasswordTextField.trailingView = confirmPasswordButton
        confirmPasswordTextField.trailingViewMode = .always
    }
    
    fileprivate func setupAnimation() {
        let fromAnimation = AnimationType.from(direction: .left, offset: 100)
        UIView.animate(views: [oldPasswordTextField, newPasswordTextField,
                               confirmPasswordTextField, layoutPasswordView],
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
            oldPasswordTextField.isSecureTextEntry = !sender.isSelected
        } else if sender.tag == 2 {
            sender.isSelected = !sender.isSelected
            newPasswordTextField.isSecureTextEntry = !sender.isSelected
        } else if sender.tag == 3 {
            sender.isSelected = !sender.isSelected
            confirmPasswordTextField.isSecureTextEntry = !sender.isSelected
        }
    }
}
