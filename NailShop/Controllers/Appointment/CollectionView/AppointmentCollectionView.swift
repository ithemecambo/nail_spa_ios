//
//  AppointmentCollectionView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/6/23.
//

import UIKit
import SwiftUI
import Foundation

protocol AppointmentCollectionViewDelegate {
    func addServiced(index: Int)
    func didSelect(index: IndexPath)
    func didSelectByTimeSlot(index: Int)
    func didSelectByNailArt(index: Int)
}

protocol AppointmentCollectionViewDataSource {
    func appointmentItemData() -> SectionAppointmentModel?
}

class AppointmentCollectionView: UICollectionView {
    
    private var sections: SectionAppointmentModel?
    
    var _delegate: AppointmentCollectionViewDelegate?
    var _dataSource: AppointmentCollectionViewDataSource?
    
    private var selectedIndexByTime = [Int]()
    private var selectedIndexByNail = [Int]()
    var didAllowSelectRowByTime: Bool = false
    var didAllowSelectRowByNailArt: Bool = false
    
    private let headerId = "headerId"
    static let headerTitleId = "headerTitleId"
    
    private (set) var selectedIndex: Int = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setupCollection()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupCollection()
    }
    
    override func reloadData() {
        sections = _dataSource?.appointmentItemData()
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .left, offset: 100)
        UIView.animate(views: self.visibleCells, animations: [fromAnimation], duration: 0.4)
    }
    
    fileprivate func setupCollection() {
        self.delegate   = self
        self.dataSource = self
        self.register(ApptTimeSlotCollectionViewCell.nib, forCellWithReuseIdentifier: ApptTimeSlotCollectionViewCell.identifier)
        self.register(ApptNailArtCollectionViewCell.nib, forCellWithReuseIdentifier: ApptNailArtCollectionViewCell.identifier)
        self.register(EmptyServiceCollectionViewCell.nib, forCellWithReuseIdentifier: EmptyServiceCollectionViewCell.identifier)
        self.register(UINib(nibName: "HeadTimeSlotReusableView", bundle: nil), forSupplementaryViewOfKind: AppointmentCollectionView.headerTitleId, withReuseIdentifier: headerId)
        self.setCollectionViewLayout(AppointmentCollectionView.createLayout(), animated: true)
    }
    
    fileprivate static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            if section == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIDevice.current.userInterfaceIdiom == .pad ? 0.10: 0.25), heightDimension: .absolute(45))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.leading = 16
                item.contentInsets.top = 5
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: headerTitleId, alignment: .topLeading)
                ]
                section.contentInsets.trailing = 16
                
                return section
            } else if section == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.leading = 16
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIDevice.current.userInterfaceIdiom == .pad ? 0.17 : 0.30), heightDimension: .absolute(130))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: headerTitleId, alignment: .topLeading)
                ]
                section.contentInsets.trailing = 16

                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets.leading = 16
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: headerTitleId, alignment: .topLeading)
                ]
                section.contentInsets.top = 5
                section.contentInsets.bottom = 16
                section.contentInsets.trailing = 16
                
                return section
            }
        }
    }
}

extension AppointmentCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return sections?.timeSlots[0].timeSlots.count ?? 0
        } else if section == 1 {
            return sections?.nailSpecialists.count ?? 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = sections
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApptTimeSlotCollectionViewCell.identifier, for: indexPath) as? ApptTimeSlotCollectionViewCell else { return UICollectionViewCell() }
            cell.timeSlot = data?.timeSlots[0].timeSlots[indexPath.row]
            if selectedIndexByTime.contains(indexPath.row) {
                cell.mainView.borderColor = .clear
                cell.mainView.backgroundColor = .systemGreen
            } else {
                cell.mainView.borderColor = .systemGreen
                cell.mainView.backgroundColor = .white
            }
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApptNailArtCollectionViewCell.identifier, for: indexPath) as? ApptNailArtCollectionViewCell else { return UICollectionViewCell() }
            cell.staffMember = data?.nailSpecialists[indexPath.row]
            if selectedIndexByNail.contains(indexPath.row) {
                cell.mainView.backgroundColor = .systemGreen
            }
            
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyServiceCollectionViewCell.identifier, for: indexPath) as? EmptyServiceCollectionViewCell else { return UICollectionViewCell() }
            cell.addServiceButton.tag = indexPath.section
            cell.delegate = self
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension AppointmentCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeadTimeSlotReusableView else { return UICollectionReusableView() }
        switch indexPath.section {
        case 0: header.titleLabel.text = "Avaiable Time".uppercased()
        case 1: header.titleLabel.text = "Nail Specialist".uppercased()
        case 2: header.titleLabel.text = "Service".uppercased()
        default: break
        }
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let type = sections![indexPath.section].items
        switch indexPath.section {
        case 0:
            if didAllowSelectRowByTime {
                selectedIndexByTime.removeAll()
                selectedIndexByTime.append(indexPath.row)
                collectionView.reloadSections(IndexSet(integer: indexPath.section))
            }
            _delegate?.didSelectByTimeSlot(index: indexPath.row)
        case 1:
            if didAllowSelectRowByNailArt {
                selectedIndexByNail.removeAll()
                selectedIndexByNail.append(indexPath.row)
                collectionView.reloadSections(IndexSet(integer: indexPath.section))
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
            _delegate?.didSelectByNailArt(index: indexPath.row)
        case 2:
            _delegate?.addServiced(index: indexPath.section)
        default: break
        }
    }
}

extension AppointmentCollectionView: EmptyServiceCollectionButtonDelegate {
    func didAddServiceButton(index: Int) {
        _delegate?.addServiced(index: index)
    }
}
