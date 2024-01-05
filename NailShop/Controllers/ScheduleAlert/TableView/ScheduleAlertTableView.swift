//
//  ScheduleAlertTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/25/23.
//

import UIKit
import Foundation

protocol ScheduleAlertTableViewDelegate {
    func didSelect(index: Int)
}

protocol ScheduleAlertTableViewDataSource {
    func scheduleAlertTimeItmeLists() -> [ScheduleAlertTimeModel]?
}

class ScheduleAlertTableView: UITableView {
    
    var _delegate: ScheduleAlertTableViewDelegate?
    var _dataSource: ScheduleAlertTableViewDataSource?
    
    private var scheduleAlertTimes: [ScheduleAlertTimeModel] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable()
    }
    
    override func reloadData() {
        scheduleAlertTimes = _dataSource?.scheduleAlertTimeItmeLists() ?? []
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .left, offset: 120)
        UIView.animate(views: self.visibleCells, animations: [fromAnimation], duration: 0.4)
    }
    
    fileprivate func setupTable() {
        self.delegate       = self
        self.dataSource     = self
        self.backgroundColor = .colorBackground
        self.register(ScheduleAlertTableViewCell.nib, forCellReuseIdentifier: ScheduleAlertTableViewCell.identifier)
    }
}

extension ScheduleAlertTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleAlertTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleAlertTableViewCell.identifier, for: indexPath) as? ScheduleAlertTableViewCell else { return UITableViewCell() }
        cell.scheduleAlertTimeViewModel = scheduleAlertTimes[indexPath.row]
        //cell.separatorInset = .zero
        
        return cell
    }
}

extension ScheduleAlertTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
