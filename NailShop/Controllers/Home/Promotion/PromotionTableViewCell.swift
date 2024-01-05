//
//  PromotionTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/20/23.
//

import UIKit
import FSPagerView

protocol PromotionTableViewDelegate {
    func didPromotionSelect(index: Int)
}

class PromotionTableViewCell: BaseTableViewCell {

    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var pageControl: FSPageControl!
    
    var delegate: PromotionTableViewDelegate?
    var promotions: [PromotionModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        self.setupPagerView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setupPagerView() {
        self.pagerView.delegate  = self
        self.pagerView.dataSource   = self
        self.pagerView.isInfinite = true
        self.pagerView.interitemSpacing = 5
        self.pagerView.automaticSlidingInterval = 5
        self.pagerView.shadowColor = .clear
        self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
        
        self.pageControl.itemSpacing = 10
        self.pageControl.interitemSpacing = 3
        self.pageControl.hidesForSinglePage = true
        self.pageControl.contentHorizontalAlignment = .right
        self.pageControl.setFillColor(.systemGreen, for: .selected)
        self.pageControl.setStrokeColor(.systemGreen, for: .selected)
        self.pageControl.setFillColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        self.pageControl.setStrokeColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.pagerView.register(UINib(nibName: "PromotionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
}

extension PromotionTableViewCell: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return promotions.count 
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as? PromotionViewCell else { return FSPagerViewCell() }
        cell.promotion = promotions[index]
        
        return cell
    }
}

extension PromotionTableViewCell: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        delegate?.didPromotionSelect(index: index)
        consoleLog(index)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
}
