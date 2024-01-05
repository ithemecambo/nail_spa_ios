//
//  RescheduleTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/24/23.
//

import UIKit
import Foundation

protocol RescheduleTableViewDelegate {
    func didSelectByTimeSlot(index: Int)
}

protocol RescheduleTableViewDataSource {
    func timeSlotItemLists() -> [TimeSlotModel]?
}

class RescheduleTableView: UICollectionView {
    
    private let headerId = "headerId"
    static let headerTitleId = "headerTitleId"
    
    private var timeSlots: [TimeSlotModel]?
    private var selectedIndexByTime = [Int]()
    var didAllowSelectRowByTime: Bool = false
    
    var _delegate: RescheduleTableViewDelegate?
    var _dataSource: RescheduleTableViewDataSource?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setupCollection()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupCollection()
    }
    
    override func reloadData() {
        timeSlots = _dataSource?.timeSlotItemLists() ?? []
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .left, offset: 100)
        UIView.animate(views: self.visibleCells, animations: [fromAnimation], duration: 0.4)
    }
    
    fileprivate func setupCollection() {
        self.delegate   = self
        self.dataSource = self
        self.register(ApptTimeSlotCollectionViewCell.nib, forCellWithReuseIdentifier: ApptTimeSlotCollectionViewCell.identifier)
        self.register(UINib(nibName: "HeadTimeSlotReusableView", bundle: nil), forSupplementaryViewOfKind: AppointmentCollectionView.headerTitleId, withReuseIdentifier: headerId)
        self.setCollectionViewLayout(RescheduleTableView.createLayout(), animated: true)
    }
    
    fileprivate static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(45))
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
        }
    }
}

extension RescheduleTableView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeSlots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApptTimeSlotCollectionViewCell.identifier, for: indexPath) as? ApptTimeSlotCollectionViewCell else { return UICollectionViewCell() }
        cell.timeSlot = timeSlots?[indexPath.row]
        if selectedIndexByTime.contains(indexPath.row) {
            cell.mainView.borderColor = .clear
            cell.mainView.backgroundColor = .systemGreen
        } else {
            cell.mainView.borderColor = .systemGreen
            cell.mainView.backgroundColor = .white
        }
        
        return cell
    }
}

extension RescheduleTableView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didAllowSelectRowByTime {
            selectedIndexByTime.removeAll()
            selectedIndexByTime.append(indexPath.row)
            collectionView.reloadSections(IndexSet(integer: indexPath.section))
        }
        _delegate?.didSelectByTimeSlot(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeadTimeSlotReusableView else { return UICollectionReusableView() }
        header.titleLabel.text = "Avaiable Time".uppercased()
        
        return header
    }
}
