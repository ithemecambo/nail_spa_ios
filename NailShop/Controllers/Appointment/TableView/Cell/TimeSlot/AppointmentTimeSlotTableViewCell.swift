//
//  AppointmentTimeSlotTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/17/23.
//

import UIKit

class AppointmentTimeSlotTableViewCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeSlotCollectionView: UICollectionView!
    @IBOutlet weak var tableConstraintHeight: NSLayoutConstraint!
    
    var timeSlots: [TimeSlotModel] = []
    private (set) var selectedIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollection()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCollection() {
        timeSlotCollectionView.delegate = self
        timeSlotCollectionView.dataSource = self
        timeSlotCollectionView.register(ApptTimeSlotCollectionViewCell.nib, forCellWithReuseIdentifier: ApptTimeSlotCollectionViewCell.identifier)
    }
    
   fileprivate func selectCell(forIndexPath indexPath: IndexPath) {
        timeSlotCollectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
        //deselect
        let prevIndexPath = IndexPath(item: selectedIndex, section: 0)
        if let prevCell = timeSlotCollectionView.cellForItem(at: prevIndexPath) {
            prevCell.isSelected = false
        }
        //select
        if let cell = timeSlotCollectionView.cellForItem(at: indexPath) as? ApptTimeSlotCollectionViewCell {
            cell.isSelected = true
        }
        selectedIndex = indexPath.row
    }
}

extension AppointmentTimeSlotTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeSlots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApptTimeSlotCollectionViewCell.identifier, for: indexPath) as? ApptTimeSlotCollectionViewCell else { return UICollectionViewCell() }
        cell.timeSlot = timeSlots[indexPath.row]
        //tableConstraintHeight.constant = collectionView.contentSize.height
//        if timeSlots[indexPath.row].status == .free {
//            cell.isSelected = indexPath.row == selectedIndex
//        }
        
        return cell
    }
}

extension AppointmentTimeSlotTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCell(forIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: (screenWidth/4)-15, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
