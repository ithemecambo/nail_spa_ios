//
//  UpdateInfoFormViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/23/23.
//

import UIKit
import MaterialComponents

class UpdateInfoFormViewController: BaseViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: MDCOutlinedTextField!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressTextField: MDCOutlinedTextField!
    @IBOutlet weak var houseNoView: UIView!
    @IBOutlet weak var houseNoTextField: MDCOutlinedTextField!
    @IBOutlet weak var streetNoView: UIView!
    @IBOutlet weak var streetNoTextField: MDCOutlinedTextField!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var cityTextField: MDCOutlinedTextField!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var stateTextField: MDCOutlinedTextField!
    @IBOutlet weak var zipcodeView: UIView!
    @IBOutlet weak var zipcodeTextField: MDCOutlinedTextField!
    @IBOutlet weak var bioView: UIView!
    @IBOutlet weak var saveButtonView: UIView!
    @IBOutlet weak var imageConstraintHeight: NSLayoutConstraint!
    
    private var imageName: String = ""
    private var imagePicker: ImagePicker!
    var viewModel: UpdateInfoFormViewModel!
    var bioTextArea: MDCOutlinedTextArea!
    
    static func instantiate() -> UpdateInfoFormViewController {
        let controller = Account.instantiateViewController(withIdentifier: String(describing: self)) as! UpdateInfoFormViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupAnimation()
        title = "Update Information"
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        guard let viewModel = viewModel else { return }
        viewModel.bindingView(self)
        guard let url = URL(string: viewModel.profile?.photoUrl ?? "") else { return }
        imageName = url.lastPathComponent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func pickButtonTapped(_ sender: UIButton) {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let viewModel = viewModel, let imageData = profileImageView.image?.jpegData(compressionQuality: 0.5) else { return }
        viewModel.uploadAvatar(profileId: viewModel.profile?.id ?? 0,
                             params: viewModel.updateInfoBody(self), 
                             imageData: imageData, fileName: self.imageName) { result in
            self.startLoading(text: Loading)
            ThreadHelper.delay(dalay: 1.5) {
                switch result {
                case .success(_):
                    ThreadHelper.delay(dalay: 0.7) {
                        viewModel.profileInfo(userId: viewModel.profile?.user?.id ?? 0) { result in
                            switch result {
                            case .success(let profile):
                                UserProfielModel.setProfile(profile)
                                self.stopLoading()
                                self.navigationController?.popToRootViewController(animated: true)
                            case .failed(let error):
                                self.stopLoading()
                                self.alertMessage(message: error)
                            }
                        }
                    }
                case .failed(let error):
                    self.stopLoading()
                    self.alertMessage(message: error)
                }
            }
        }
    }
}

extension UpdateInfoFormViewController {
    fileprivate func setupLayout() {
        phoneTextField.label.text = "Phone"
        phoneTextField.setOutlineColor(.systemGray, for: .normal)
        phoneTextField.setOutlineColor(.systemGreen, for: .editing)
        phoneTextField.leadingView = UIImageView(image: UIImage(systemName: "phone.circle.fill"))
        phoneTextField.leadingViewMode = .always
        
        addressTextField.label.text = "Address"
        addressTextField.setOutlineColor(.systemGray, for: .normal)
        addressTextField.setOutlineColor(.systemGreen, for: .editing)
        addressTextField.leadingView = UIImageView(image: UIImage(systemName: "mappin.circle.fill"))
        addressTextField.leadingViewMode = .always
        
        houseNoTextField.label.text = "House No."
        houseNoTextField.setOutlineColor(.systemGray, for: .normal)
        houseNoTextField.setOutlineColor(.systemGreen, for: .editing)
        houseNoTextField.leadingView = UIImageView(image: UIImage(systemName: "house.circle.fill"))
        houseNoTextField.leadingViewMode = .always
        
        streetNoTextField.label.text = "Street No."
        streetNoTextField.setOutlineColor(.systemGray, for: .normal)
        streetNoTextField.setOutlineColor(.systemGreen, for: .editing)
        streetNoTextField.leadingView = UIImageView(image: UIImage(systemName: "signpost.right.fill"))
        streetNoTextField.leadingViewMode = .always
        
        cityTextField.label.text = "City"
        cityTextField.setOutlineColor(.systemGray, for: .normal)
        cityTextField.setOutlineColor(.systemGreen, for: .editing)
        cityTextField.leadingView = UIImageView(image: UIImage(systemName: "flag.circle.fill"))
        cityTextField.leadingViewMode = .always
        
        stateTextField.label.text = "State"
        stateTextField.setOutlineColor(.systemGray, for: .normal)
        stateTextField.setOutlineColor(.systemGreen, for: .editing)
        stateTextField.leadingView = UIImageView(image: UIImage(systemName: "building.2.crop.circle.fill"))
        stateTextField.leadingViewMode = .always
        
        zipcodeTextField.label.text = "Zip Code"
        zipcodeTextField.setOutlineColor(.systemGray, for: .normal)
        zipcodeTextField.setOutlineColor(.systemGreen, for: .editing)
        zipcodeTextField.leadingView = UIImageView(image: UIImage(systemName: "ellipsis.circle.fill"))
        zipcodeTextField.leadingViewMode = .always
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
    }
    
    fileprivate func setupAnimation() {
        let fromAnimation = AnimationType.from(direction: .right, offset: 120)
        UIView.animate(views: [profileImageView, photoView, phoneView, addressView,
                               houseNoView, streetNoView, cityView, stateView,
                               zipcodeView, bioView, saveButtonView],
                       animations: [fromAnimation],
                       duration: 0.5)
    }
}

extension UpdateInfoFormViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        profileImageView.image = image
    }
    
    func getImageName(fileName: String?) {
        guard let fileName = fileName else { return }
        imageName = fileName
    }
}
