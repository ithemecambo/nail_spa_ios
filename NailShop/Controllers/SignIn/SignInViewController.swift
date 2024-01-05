//
//  SignInViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import Alamofire
import MaterialComponents

class SignInViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var telView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var bioView: UIView!
    @IBOutlet weak var createAccView: UIView!
    @IBOutlet weak var alreadyView: UIView!
    
    @IBOutlet weak var firstNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var lastNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var telTextField: MDCOutlinedTextField!
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    @IBOutlet weak var addressTextField: MDCOutlinedTextField!
    @IBOutlet weak var signInLabel: UILabel!
    
    private var imagePicker: ImagePicker!
    var bioTextArea: MDCOutlinedTextArea!
    
    private var user: UserModel?
    private var imageName: String = ""
    private var viewModel = SignInViewModel()
    private var router = DefaultSignInRouter()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-hh:mm:ss"
        return formatter
    }()
    
    static func instatiate() -> SignInViewController {
        let controller = Main.instantiateViewController(withIdentifier: String(describing: self)) as! SignInViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupAnimation()
        self.indicatorView.alpha = 0
        profileImageView.isUserInteractionEnabled = true
        navigationController?.isNavigationBarHidden = false
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                         action: #selector(avatarButtonTapped(_:))))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        mainView.endEditing(true)
    }
    
    @IBAction func avatarButtonTapped(_ sender: UIButton) {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func createAccButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.viewModel.valid(firstName: firstNameTextField.text, lastName: lastNameTextField.text, tel: telTextField.text, address: addressTextField.text, email: emailTextField.text, password: passwordTextField.text) { result in
            switch result {
            case .success(let success):
                if success == "success" {
                    self.startLoading(text: Loading)
                    ThreadHelper.delay(dalay: 1.5) {
                        self.createAccount(username: self.emailTextField.text ?? "",
                                           password: self.passwordTextField.text ?? "")
                    }
                }
            case .failed(let error):
                self.alertMessage(message: error)
            }
        }
    }
}

extension SignInViewController {
    func setupLayout() {
        imageName = "avatar-profile-\(self.dateFormatter.string(from: Date())).jpeg"
        firstNameTextField.label.text = "Give Name"
        firstNameTextField.setOutlineColor(.systemGray, for: .normal)
        firstNameTextField.setOutlineColor(.systemGreen, for: .editing)
        firstNameTextField.leadingView = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        firstNameTextField.leadingViewMode = .always
        
        lastNameTextField.label.text = "Family Name"
        lastNameTextField.setOutlineColor(.systemGray, for: .normal)
        lastNameTextField.setOutlineColor(.systemGreen, for: .editing)
        lastNameTextField.leadingView = UIImageView(image: UIImage(systemName: "rectangle.on.rectangle.circle.fill"))
        lastNameTextField.leadingViewMode = .always
        
        telTextField.label.text = "Tel"
        telTextField.setOutlineColor(.systemGray, for: .normal)
        telTextField.setOutlineColor(.systemGreen, for: .editing)
        telTextField.leadingView = UIImageView(image: UIImage(systemName: "phone.circle.fill"))
        telTextField.leadingViewMode = .always
        
        addressTextField.label.text = "Address"
        addressTextField.setOutlineColor(.systemGray, for: .normal)
        addressTextField.setOutlineColor(.systemGreen, for: .editing)
        addressTextField.leadingView = UIImageView(image: UIImage(systemName: "mappin.circle.fill"))
        addressTextField.leadingViewMode = .always
        
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
        var width: CGFloat = 0.0
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            width = UIScreen._width - 40
        } else {
            width = bioView.frame.width - (UIScreen.main.bounds.height >= 812 ? -35: 20)
        }
        bioTextArea = MDCOutlinedTextArea(frame: CGRect(x: 0, y: 10, width: width , height: 260))
        bioTextArea.label.text = "Bio"
        bioTextArea.setOutlineColor(.systemGray, for: .normal)
        bioTextArea.setOutlineColor(.systemGreen, for: .editing)
        bioTextArea.minimumNumberOfVisibleRows = 4
        bioTextArea.textView.font = .systemFont(ofSize: 15)
        bioView.addSubview(bioTextArea)
        
        signInLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signInButtonTapped(_:))))
    }
    
    func setupAnimation() {
        let fromAnimation = AnimationType.from(direction: .left, offset: 120)
        UIView.animate(views: [avatarView, firstNameView, lastNameView, 
                               telView, addressView, emailView, passwordView, bioView,
                               createAccView, alreadyView],
                       animations: [fromAnimation],
                       duration: 0.5)
    }
    
    @objc func signInButtonTapped(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func createAccount(username: String, password: String) {
        // Create account depend on base `User`
        viewModel.createAccount(param: viewModel.bodyAccount(self)) { result in
            switch result {
            case .success(let user):
                self.user = user
                ThreadHelper.delay(dalay: 1.0) {
                    guard let imageData = self.profileImageView.image?.jpegData(compressionQuality: 0.5) else { return }
                    // Upload profile
                    self.viewModel.uploadAvatar(param: self.viewModel.bodyUserProfile(user, from: self), data: imageData, fileName: self.imageName) { result in
                        switch result {
                        case .success(let success):
                            if success == "success" {
                                ThreadHelper.delay(dalay: 0.5) {
                                    // Auto Login account
                                    self.viewModel.autoLogin(username: username, password: password) { result in
                                        switch result {
                                        case .success(let login):
                                            LoginModel.setUser(user: login)
                                            // Get User Profile
                                            self.viewModel.getProfile(userId: login.userId) { result in
                                                switch result {
                                                case .success(let profile):
                                                    UserProfielModel.setProfile(profile)
                                                    self.router.perform(.createAccount, from: self)
                                                case .failed(let error):
                                                    self.alertMessage(message: error)
                                                }
                                            }
                                        case .failed(let error):
                                            self.alertMessage(message: error)
                                            self.stopLoading()
                                        }
                                    }
                                }
                            }
                            self.stopLoading()
                        case .failed(let error):
                            self.alertMessage(message: error)
                            self.stopLoading()
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

extension SignInViewController: ImagePickerDelegate {
    func getImageName(fileName: String?) {
        guard let fileName = fileName else { return }
        imageName = fileName
    }
    
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        profileImageView.image = image
    }
}
