//
//  GalleryTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/20/23.
//

import UIKit

protocol GalleryTableViewDelegate {
    func didGallerySelect(index: Int)
}

class GalleryTableViewCell: BaseTableViewCell {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var collectionConstraintHeight: NSLayoutConstraint!
    
    var delegate: GalleryTableViewDelegate?
    var galleries: [GalleryModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollection()
        selectionStyle = .none
        backgroundColor = .clear
        galleryCollectionView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setupCollection() {
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(GalleryViewCell.nib, forCellWithReuseIdentifier: GalleryViewCell.identifier)
    }
}

extension GalleryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryViewCell.identifier, for: indexPath) as? GalleryViewCell else { return UICollectionViewCell() }
        cell.gallery = galleries[indexPath.row]
        collectionConstraintHeight.constant = collectionView.contentSize.height// - 242
        
        return cell
    }
}

extension GalleryTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didGallerySelect(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalHeight: CGFloat = (UIScreen.main.bounds.width / 3.3)
        let totalWidth: CGFloat = (UIScreen.main.bounds.width / 3.2)
        return CGSize(width: ceil(totalWidth) - (UIScreen.main.bounds.height >= 812 ? 10.25: 11.25), height: ceil(totalHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
