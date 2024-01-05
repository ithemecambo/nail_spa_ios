//
//  HomeTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit
import Foundation

protocol HomeTableViewDelegate {
    func promotionSelected(index: Int)
    func nailArtSelected(index: Int)
    func serviceSelected(index: Int)
    func bookingSelected(index: Int)
    func gallerySelected(index: Int)
}

protocol HomeTableViewDataSource {
    func homeData() -> HomeModel?
}

class HomeTableView: UITableView {
    
    private var data: HomeModel?
    private (set) var selectedIndex: Int? = 0
    var _delegate: HomeTableViewDelegate?
    var _dataSource: HomeTableViewDataSource?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable()
    }
    
    private func setupTable() {
        self.contentInset   = .init(top: 10, left: 0, bottom: 10, right: 0)
        self.delegate       = self
        self.dataSource     = self
        self.separatorStyle = .none
        self.backgroundColor = .colorBackground
        self.register(PromotionTableViewCell.nib, forCellReuseIdentifier: PromotionTableViewCell.identifier)
        self.register(CategoryTableViewCell.nib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        self.register(NailArtTableViewCell.nib, forCellReuseIdentifier: NailArtTableViewCell.identifier)
        self.register(ServiceTableViewCell.nib, forCellReuseIdentifier: ServiceTableViewCell.identifier)
        self.register(PackageTableViewCell.nib, forCellReuseIdentifier: PackageTableViewCell.identifier)
        self.register(BusinessHourTableViewCell.nib, forCellReuseIdentifier: BusinessHourTableViewCell.identifier)
        self.register(GalleryTableViewCell.nib, forCellReuseIdentifier: GalleryTableViewCell.identifier)
    }
    
    override func reloadData() {
        data = _dataSource?.homeData() 
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .left, offset: 100)
        UIView.animate(views: self.visibleCells, animations: [fromAnimation], duration: 0.4)
    }
}

extension HomeTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return [data?.promotions].count
        // case 1: return 1
        case 1: return [data?.staffMembers].count
        case 2: return [data?.services].count
        case 3: return [data?.galleries].count
        case 4: return [data?.businessOpenHours].count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PromotionTableViewCell.identifier, for: indexPath) as? PromotionTableViewCell else { return UITableViewCell() }
            cell.promotions = data?.promotions ?? []
            cell.pageControl.numberOfPages = data?.promotions?.count ?? 0
            cell.pagerView.reloadData()
            cell.delegate = self
            
            return cell
//        case 1:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
//            
//            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NailArtTableViewCell.identifier, for: indexPath) as? NailArtTableViewCell else { return UITableViewCell() }
            cell.staffMembers = data?.staffMembers ?? []
            cell.nailArtCollectionView.reloadData()
            cell.delegate = self
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.identifier, for: indexPath) as? PackageTableViewCell else { return UITableViewCell() }
            cell.services = data?.services ?? []
            cell.tableView.reloadData()
            cell.layoutIfNeeded()
            cell.delegate = self
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GalleryTableViewCell.identifier, for: indexPath) as? GalleryTableViewCell else { return UITableViewCell() }
            cell.galleries = data?.galleries ?? []
            cell.layoutSubviews()
            cell.galleryCollectionView.reloadData()
            cell.layoutIfNeeded()
            cell.delegate = self
            
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BusinessHourTableViewCell.identifier, for: indexPath) as? BusinessHourTableViewCell else { return UITableViewCell() }
            cell.businessHours = data?.businessOpenHours ?? []
            cell.tableView.reloadData()
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension HomeTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return UIDevice.current.userInterfaceIdiom == .pad ? 350: 150
        // case 1: return 140
        case 1: return 200
        default: return UITableView.automaticDimension
        }
    }
}

extension HomeTableView: PromotionTableViewDelegate {
    func didPromotionSelect(index: Int) {
        _delegate?.promotionSelected(index: index)
    }
}

extension HomeTableView: NailArtTableViewDelegate {
    func didNailArtSelect(index: Int) {
        _delegate?.promotionSelected(index: index)
    }
}

extension HomeTableView: PackageButtonDelegate {
    func bookingTapped(index: Int) {
        _delegate?.bookingSelected(index: index)
    }
    
    func didServiceSelect(index: Int) {
        _delegate?.serviceSelected(index: index)
    }
}

extension HomeTableView: GalleryTableViewDelegate {
    func didGallerySelect(index: Int) {
        _delegate?.gallerySelected(index: index)
    }
}
