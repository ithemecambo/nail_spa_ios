//
//  HomeViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import SKPhotoBrowser

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: HomeTableView! {
        didSet {
            self.tableView._delegate    = self
            self.tableView._dataSource  = self
        }
    }
    
    private var data = HomeModel()
    private var viewModel = HomeViewModel()
    private var router = DefaultHomeRouter()
    
    static func instantiate() -> HomeViewController {
        let controller = Main.instantiateViewController(withIdentifier: String(describing: self)) as! HomeViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoading(text: Loading)
        self.getData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Nail & Spa"
        CoreDataManager.shared.delete()
    }
    
    private var getData: () {
        viewModel.getNailSpa { result in
            switch result {
            case .success(let data):
                self.data = data
                self.stopLoading()
                ThreadHelper.delay(dalay: 0.6) {
                    self.tableView.alpha = 1
                }
            case .failed(let error):
                self.stopLoading()
                self.tableView.alpha = 0
                if error == "noResult" {
                    self.router.perform(.main, from: self)
                    return
                }
                self.alertMessage(message: error)
            }
            //HomeModel.toJson(model: self.data)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func notificationButtonTapped(_ sender: UIBarButtonItem) {
        router.perform(.notification, from: self)
    }
}

extension HomeViewController: HomeTableViewDataSource {
    func homeData() -> HomeModel? {
        return data
    }
}

extension HomeViewController: HomeTableViewDelegate {
    func promotionSelected(index: Int) {
        consoleLog(data.promotions?[index] ?? "")
    }
    
    func nailArtSelected(index: Int) {
        consoleLog(data.staffMembers?[index] ?? "")
    }
    
    func serviceSelected(index: Int) {
        self.router.perform(.service("home"), from: self)
    }
    
    func bookingSelected(index: Int) {
        self.router.perform(.booking, from: self)
    }
    
    func gallerySelected(index: Int) {
        guard let galleries = data.galleries else { return }
        let browser = SKPhotoBrowser(photos: loadImages(galleries), initialPageIndex: index)
        self.present(browser, animated: true)
    }
    
    fileprivate func loadImages(_ photos: [GalleryModel]) -> [SKPhotoProtocol] {
        var galleries: [SKPhotoProtocol] = []
        photos.forEach { imageUrl in
            let photo = SKPhoto.photoWithImageURL(imageUrl.photoUrl ?? "")
            photo.shouldCachePhotoURLImage = true
            galleries.append(photo)
        }
        return galleries
    }
}
