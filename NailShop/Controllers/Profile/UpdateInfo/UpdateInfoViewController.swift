//
//  UpdateInfoViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/8/23.
//

import UIKit

class UpdateInfoViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UpdateInfoTableView! {
        didSet {
            self.tableView._delegate    = self
            self.tableView._dataSource  = self
        }
    }
    
    private var isEdited: Bool = false
    private var imageName: String = ""
    private var imagePicker: ImagePicker!
    private var profiles: [ProfileInfo] = []
    private var profileUser = UserProfielModel()
    private var viewModel = UpdateInfoViewModel()
    private var router = DefaultUpdateInfoRouter()
    
    static func instantiate() -> UpdateInfoViewController {
        let controller = Account.instantiateViewController(identifier: String(describing: self)) as! UpdateInfoViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        self.isEdited = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !isEdited {
            tabBarController?.tabBar.isHidden = false
            navigationController?.isNavigationBarHidden = true
        }
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        self.isEdited = true
        self.router.perform(.editInfo(profileUser), from: self)
    }
    
    fileprivate func fetchProfile() {
        guard let user = UserProfielModel.getProfile() else { return }
        viewModel.profileInfo(userId: user.user?.id ?? 0) { result in
            switch result {
            case .success(let profile):
                self.profileUser = profile
                UserProfielModel.setProfile(profile)
                self.profiles.append(ProfileInfo(icon: "person.crop.circle.fill", key: "Give Name", value: profile.user?.firstName ?? ""))
                self.profiles.append(ProfileInfo(icon: "rectangle.on.rectangle.circle.fill", key: "Family Name", value: profile.user?.lastName ?? ""))
                self.profiles.append(ProfileInfo(icon: "envelope.circle.fill", key: "Email", value: profile.user?.email ?? ""))
                self.profiles.append(ProfileInfo(icon: "phone.circle.fill", key: "Phone", value: profile.phone ?? ""))
                self.profiles.append(ProfileInfo(icon: "mappin.circle.fill", key: "Address", value: profile.address ?? ""))
                self.profiles.append(ProfileInfo(icon: "house.circle.fill", key: "House #", value: profile.houseNo ?? ""))
                self.profiles.append(ProfileInfo(icon: "signpost.right.fill", key: "Street #", value: profile.streetNo ?? ""))
                self.profiles.append(ProfileInfo(icon: "flag.circle.fill", key: "City", value: profile.city ?? ""))
                self.profiles.append(ProfileInfo(icon: "building.2.crop.circle.fill", key: "State", value: profile.state ?? ""))
                self.profiles.append(ProfileInfo(icon: "ellipsis.circle.fill", key: "Zip Code", value: profile.zipcode ?? ""))
                profile.photoUrl == "" ? (self.tableView.header.profileImageView.image = UIImage(named: "avatar-profile")):
                (self.tableView.header.profileImageView.loadImage(url: "\(Configuration.baseUrl)\(profile.photoUrl ?? "")"))
                
            case .failed(let error):
                self.alertMessage(message: error)
            }
            self.tableView.reloadData()
        }
    }
}

extension UpdateInfoViewController: UpdateInfoTableViewDataSource {
    func profileItemList() -> [ProfileInfo]? {
        return profiles
    }
}

extension UpdateInfoViewController: UpdateInfoTableViewDelegate {
    func didScrollView(scrollView: UIScrollView) {
       
    }
    
    func profileButtonTapped(sender: UIButton) {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.imagePicker.present(from: sender)
    }
}

extension UpdateInfoViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        tableView.header.profileImageView.image = image
        guard let profile = UserProfielModel.getProfile(), 
                let imageData = tableView.header.profileImageView.image?.jpegData(compressionQuality: 0.5) else { return }
        viewModel.uploadAvatar(profileId: profile.id, imageData: imageData, fileName: imageName) { result in
            self.tableView.header.indicatorView.startAnimating()
            self.tableView.header.indicatorView.alpha = 1
            ThreadHelper.delay(dalay: 1.5) {
                switch result {
                case .success(let success):
                    if success == "success" {
                        self.tableView.header.indicatorView.stopAnimating()
                        self.tableView.header.indicatorView.alpha = 0
                        self.profiles.removeAll()
                        self.fetchProfile()
                    }
                case .failed(let error):
                    self.tableView.header.indicatorView.stopAnimating()
                    self.tableView.header.indicatorView.alpha = 0
                    self.alertMessage(message: error)
                }
            }
        }
        
    }
    
    func getImageName(fileName: String?) {
        guard let fileName = fileName else { return }
        imageName = fileName
    }
}
