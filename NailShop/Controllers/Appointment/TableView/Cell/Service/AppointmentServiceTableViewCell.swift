//
//  AppointmentServiceTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/17/23.
//

import UIKit

class AppointmentServiceTableViewCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var tableConstraintHeight: NSLayoutConstraint!
    
    var services: [Service] = []
    private (set) var selectedIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollection()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setupCollection() {
        serviceCollectionView.delegate  = self
        serviceCollectionView.dataSource = self
        serviceCollectionView.register(ApptServiceCollectionViewCell.nib, forCellWithReuseIdentifier: ApptServiceCollectionViewCell.identifier)
    }
    
    fileprivate func selectCell(forIndexPath indexPath: IndexPath) {
        serviceCollectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
        //deselect
        let prevIndexPath = IndexPath(item: selectedIndex, section: 0)
        if let prevCell = serviceCollectionView.cellForItem(at: prevIndexPath) {
            prevCell.isSelected = false
        }
        //select
        if let cell = serviceCollectionView.cellForItem(at: indexPath) as? ApptServiceCollectionViewCell {
            cell.isSelected = true
        }
        selectedIndex = indexPath.row
    }
}

extension AppointmentServiceTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApptServiceCollectionViewCell.identifier, for: indexPath) as? ApptServiceCollectionViewCell else { return UICollectionViewCell() }
        //cell.service = services[indexPath.row]
        cell.isSelected = indexPath.row == selectedIndex
        //tableConstraintHeight.constant = collectionView.contentSize.height
        
        return cell
    }
}

extension AppointmentServiceTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCell(forIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberofItem: CGFloat = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let collectionViewWidth = self.serviceCollectionView.bounds.width
        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
        return CGSize(width: Int(collectionView.bounds.width), height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
