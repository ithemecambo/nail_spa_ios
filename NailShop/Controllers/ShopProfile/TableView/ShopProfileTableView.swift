//
//  ShopProfileTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/7/23.
//

import UIKit
import Foundation

protocol ShopProfileTableViewDelegate {
    
}

protocol ShopProfileTableViewDataSource {
    func profileDetail() -> [ProfileDetailModel]
}

class ShopProfileTableView: UITableView {
    
    var profileData: [ProfileDetailModel] = []
    var _delegate: ShopProfileTableViewDelegate?
    var _dataSource: ShopProfileTableViewDataSource?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable
    }
    
    override func reloadData() {
        profileData = _dataSource?.profileDetail() ?? []
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .right, offset: 100)
        UIView.animate(views: visibleCells,
                       animations: [fromAnimation],
                       duration: 0.4)
    }
    
    private var setupTable: () {
        self.delegate           = self
        self.dataSource         = self
        self.estimatedRowHeight = 100
        self.separatorStyle     = .none
        self.rowHeight          = UITableView.automaticDimension
        self.register(ProfileBannerTableViewCell.nib, forCellReuseIdentifier: ProfileBannerTableViewCell.identifier)
        self.register(ProfileHeaderTableViewCell.nib, forCellReuseIdentifier: ProfileHeaderTableViewCell.identifier)
        self.register(ProfileSpecialistTableViewCell.nib, forCellReuseIdentifier: ProfileSpecialistTableViewCell.identifier)
        self.register(OpeningHourTableViewCell.nib, forCellReuseIdentifier: OpeningHourTableViewCell.identifier)
        self.register(ProfileAboutTableViewCell.nib, forCellReuseIdentifier: ProfileAboutTableViewCell.identifier)
        self.register(ProfileMapTableViewCell.nib, forCellReuseIdentifier: ProfileMapTableViewCell.identifier)
    }
}

extension ShopProfileTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileBannerTableViewCell.identifier, for: indexPath) as? ProfileBannerTableViewCell else { return UITableViewCell() }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderTableViewCell.identifier, for: indexPath) as? ProfileHeaderTableViewCell else { return UITableViewCell() }
            cell.profileData = profileData[0]
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSpecialistTableViewCell.identifier, for: indexPath) as? ProfileSpecialistTableViewCell else { return UITableViewCell() }
            cell.nailArts = profileData[0].specialists ?? []
            cell.nailArtCollectionView.reloadData()
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OpeningHourTableViewCell.identifier, for: indexPath) as? OpeningHourTableViewCell else { return UITableViewCell() }
            cell.openingHours = profileData[0].openingHours ?? []
            cell.tableView.reloadData()
            
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileAboutTableViewCell.identifier, for: indexPath) as? ProfileAboutTableViewCell else { return UITableViewCell() }
            
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMapTableViewCell.identifier, for: indexPath) as? ProfileMapTableViewCell else {
                return UITableViewCell() }
            cell.profileData = profileData[0]
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ShopProfileTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0: return 450
            case 1: return UITableView.automaticDimension
            case 2: return 160
            case 5: return 300
            default: return UITableView.automaticDimension
        }
    }
}

