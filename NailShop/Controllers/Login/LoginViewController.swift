//
//  LoginViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import MaterialComponents

class LoginViewController: BaseViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var socailView: UIStackView!
    @IBOutlet weak var loginView: UIStackView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    
    private var router = DefaultLoginRouter()
    private var viewModel = LoginViewModel()
    
    static func instantiate() -> LoginViewController {
        let controller = Main.instantiateViewController(withIdentifier: String(describing: self)) as! LoginViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        KeyboardAvoiding.avoidingView = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupAnimation()
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        self.startLoading(text: Loading)
        viewModel.loginByFacebook(from: self) { result in
            switch result {
            case .success(let facebookUser):
                self.navigator(socailUser: facebookUser)
            case .failed(let error):
                self.stopLoading()
                self.alertMessage(message: error)
            }
        }
    }
    
    @IBAction func googleButtonTapped(_ sender: UIButton) {
        self.startLoading(text: Loading)
        viewModel.loginByGoogle(from: self) { result in
            switch result {
            case .success(let googleUser):
                self.navigator(socailUser: googleUser)
            case .failed(let error):
                self.stopLoading()
                self.alertMessage(message: error)
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.viewModel.login(email: self.emailTextField.text,
                             password: self.passwordTextField.text) { result in
            switch result {
            case .success(let success):
                if success == "success" {
                    self.startLoading(text: Loading)
                    ThreadHelper.delay(dalay: 1.5) {
                        guard let isLogin = LoginModel.getUser() else { return }
                        self.viewModel.getProfile(userId: isLogin.userId) { result in
                            switch result {
                            case .success(let profile):
                                consoleLog(profile)
                                UserProfielModel.setProfile(profile)
                                self.router.perform(.login, from: self)
                            case .failed(let error):
                                self.alertMessage(message: error)
                                self.stopLoading()
                            }
                        }
                    }
                }
            case .failed(let error):
                self.alertMessage(message: error)
                self.stopLoading()
            }
        }
    }
}

extension LoginViewController {
    fileprivate func setupLayout() {
        emailTextField.label.text = "Email"
        emailTextField.setOutlineColor(.systemGray, for: .normal)
        emailTextField.setOutlineColor(.systemGreen, for: .editing)
        emailTextField.leadingView = UIImageView(image: UIImage(systemName: "envelope.circle.fill"))
        emailTextField.leadingViewMode = .always
        
        passwordTextField.label.text = "Password"
        passwordTextField.setOutlineColor(.systemGray, for: .normal)
        passwordTextField.setOutlineColor(.systemGreen, for: .editing)
        passwordTextField.leadingView = UIImageView(image: UIImage(systemName: "lock.circle.fill"))
        passwordTextField.leadingViewMode = .always
        
        let passwordButton = UIButton(type: .custom)
        passwordButton.frame = CGRect(x: 0, y: 0,
                                      width: 24, height: CGFloat(passwordTextField.frame.height))
        passwordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordButton.addTarget(self, action: #selector(showSecurePasswordTapped(_:)), for: .touchUpInside)
        
        passwordTextField.trailingView = passwordButton
        passwordTextField.trailingViewMode = .always
        forgetPasswordLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgetPasswordLabelTapped(_:))))
        
        signUpLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signUpLabelTapped(_:))))
    }
    
    fileprivate func setupAnimation() {
        let fromAnimation = AnimationType.from(direction: .left, offset: 120)
        UIView.animate(views: [mainView, socailView, loginView, emailView, passwordView, forgetPasswordLabel, loginButton, accountLabel, signUpLabel], animations: [fromAnimation], duration: 0.4)
    }
    
    @objc func showSecurePasswordTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
    
    @objc func forgetPasswordLabelTapped(_ sender: UITapGestureRecognizer) {
        self.router.perform(.forgetPassword("forget"), from: self)
    }
    
    @objc func signUpLabelTapped(_ sender: UITapGestureRecognizer) {
        self.router.perform(.signUp, from: self)
    }
    
    fileprivate func navigator(socailUser: SocialLoginModel) {
        self.viewModel.checkAnEmail(email: socailUser.email ?? "") { result in
            ThreadHelper.delay(dalay: 0.7) {
                switch result {
                case .success(let user):
                    consoleLog("User: \(user)")
                    self.stopLoading()
                    self.alertMessage(message: "Your have an already account. Please try an other emails.")
                case .failed(_):
                    self.stopLoading()
                    self.router.perform(.google(socailUser), from: self)
                }
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            KeyboardAvoiding.padding = -80
            KeyboardAvoiding.avoidingView = mainView
        } else if textField == self.passwordTextField {
            KeyboardAvoiding.padding = -50
            KeyboardAvoiding.avoidingView = textField
            KeyboardAvoiding.padding = 0
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.emailTextField.becomeFirstResponder()
        } else if textField == self.passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
