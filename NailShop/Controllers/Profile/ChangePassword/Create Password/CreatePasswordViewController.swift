//
//  CreatePasswordViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/28/23.
//

import UIKit
import MaterialComponents

class CreatePasswordViewController: BaseViewController {
    
    @IBOutlet weak var displayInfoLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: MDCOutlinedTextField!
    @IBOutlet weak var confirmPasswordTextField: MDCOutlinedTextField!
    @IBOutlet weak var layoutPasswordView: UIView!
    
    private var imageName: String = ""
    var viewModel: CreatePasswordViewModel!
    private var router = DefaultCreatePasswordRouter()
    
    static func instantiate() -> CreatePasswordViewController {
        let controller = Setting.instantiateViewController(withIdentifier: String(describing: self)) as! CreatePasswordViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupAnimation()
        title = "Create Password"
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        guard let viewModel = viewModel else { return }
        viewModel.validation(newPassword: newPasswordTextField.text ?? "", confirmPassword: confirmPasswordTextField.text ?? "") { result in
            switch result {
            case .success(let success):
                if success == "Success" {
                    self.startLoading(text: Loading)
                    ThreadHelper.delay(dalay: 1.0) {
                        self.createAccount(username: viewModel.socialUser?.email ?? "", password: self.newPasswordTextField.text ?? "")
                    }
                }
            case .failed(let error):
                self.alertMessage(message: error)
            }
        }
    }
}

extension CreatePasswordViewController {
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
        UIView.animate(views: [displayInfoLabel, newPasswordTextField, confirmPasswordTextField,
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
    
    fileprivate func createAccount(username: String, password: String) {
        guard let viewModel = viewModel else { return }
        viewModel.createAccount(params: viewModel.accountBody(viewModel.socialUser, from: self)) { result in
            switch result {
            case .success(let user):
                consoleLog("user: \(user)")
                ThreadHelper.delay(dalay: 0.7) {
                    guard let imageData = UIImageView(image: UIImage(named: "avatar-profile")).image?.jpegData(compressionQuality: 0.5) else { return }
                    self.imageName = "avatar-profile-\(Int.random(in: 2737...449999)).jpeg"
                    viewModel.createProfile(params: viewModel.profileBody(user), data: imageData, fileName: self.imageName) { result in
                        switch result {
                        case .success(let createProfile):
                            consoleLog("createProfile: \(createProfile)")
                            viewModel.autoLogin(username: username, password: password) { result in
                                switch result {
                                case .success(let login):
                                    LoginModel.setUser(user: login)
                                    viewModel.getProfile(userId: login.userId) { result in
                                        switch result {
                                        case .success(let profile):
                                            UserProfielModel.setProfile(profile)
                                            self.router.perform(.main, from: self)
                                        case .failed(let error):
                                            self.stopLoading()
                                            self.alertMessage(message: error)
                                        }
                                    }
                                case .failed(let loginError):
                                    self.stopLoading()
                                    self.alertMessage(message: loginError)
                                }
                            }
                        case .failed(let createError):
                            self.stopLoading()
                            self.alertMessage(message: createError)
                        }
                    }
                }
            case .failed(let userError):
                self.stopLoading()
                self.alertMessage(message: userError)
            }
        }
    }
}
