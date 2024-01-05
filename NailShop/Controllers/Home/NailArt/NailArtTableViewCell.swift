//
//  NailArtTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit

protocol NailArtTableViewDelegate {
    func didNailArtSelect(index: Int)
}

class NailArtTableViewCell: BaseTableViewCell {

    @IBOutlet weak var nailArtCollectionView: UICollectionView!
    
    var delegate: NailArtTableViewDelegate?
    var staffMembers: [StaffMemberModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
        self.setupCollection()
        nailArtCollectionView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setupCollection() {
        nailArtCollectionView.delegate = self
        nailArtCollectionView.dataSource = self
        nailArtCollectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: -10)
        nailArtCollectionView.register(NailArtViewCell.nib, forCellWithReuseIdentifier: NailArtViewCell.identifier)
    }
}

extension NailArtTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return staffMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NailArtViewCell.identifier, for: indexPath) as? NailArtViewCell else { return UICollectionViewCell() }
        cell.staffMember = staffMembers[indexPath.row]
        
        return cell
    }
}

extension NailArtTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didNailArtSelect(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        var column: CGFloat = 0.0
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            column = (screenWidth/5.5)-15
        } else {
            column = (screenWidth/2.5)-15
        }
        return CGSize(width: column, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
