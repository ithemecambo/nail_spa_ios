//
//  MyBookingTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import UIKit
import Foundation

protocol MyBookingTableViewDelegate {
    func enableNotificationTapped(sender: UISwitch)
    func alertNotificationTapped(sender: UIButton)
    func rescheduleBookingTapped(sender: UIButton)
    func cancelBookingTapped(sender: UIButton)
    func reviewBookingTapped(sender: UIButton)
}

protocol MyBookingTableViewDataSource {
    func myBookings() -> [MyBookingModel]
}

class MyBookingTableView: UITableView {
    
    var _delegate: MyBookingTableViewDelegate?
    var _dataSource: MyBookingTableViewDataSource?
    
    fileprivate var bookings: [MyBookingModel] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable()
    }
    
    override func reloadData() {
        bookings = _dataSource?.myBookings() ?? []
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .right, offset: 120)
        UIView.animate(views: visibleCells, animations: [fromAnimation], duration: 0.4)
    }
    
    private func setupTable() {
        self.contentInset   = .init(top: 10, left: 0, bottom: 0, right: 0)
        self.dataSource     = self
        self.backgroundColor = .colorBackground
        self.separatorStyle = .none
        self.register(UpcomingTableViewCell.nib, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        self.register(CompletedTableViewCell.nib, forCellReuseIdentifier: CompletedTableViewCell.identifier)
    }
}

extension MyBookingTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let booking = bookings[indexPath.row]
        switch booking.appointmentId?.appointmentStatus {
        case "Upcoming":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else { return UITableViewCell() }
            cell.upcomingViewModel = booking
            cell.alertSwitch.tag = indexPath.row
            cell.cancelButton.tag = indexPath.row
            cell.rescheduleButton.tag = indexPath.row
            cell.notificationButton.tag = indexPath.row
            cell.delegate = self
            
            return cell
            
        case "Completed":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CompletedTableViewCell.identifier, for: indexPath) as? CompletedTableViewCell else { return UITableViewCell() }
            cell.completedViewModel = booking
            cell.reviewButton.tag = indexPath.row
            cell.delegate = self
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MyBookingTableView: UpcomingBookingDelegate {
    func enableNotificationTapped(sender: UISwitch) {
        _delegate?.enableNotificationTapped(sender: sender)
    }
    
    func alertNotificationTapped(sender: UIButton) {
        _delegate?.alertNotificationTapped(sender: sender)
    }
    
    func rescheduleTapped(sender: UIButton) {
        _delegate?.rescheduleBookingTapped(sender: sender)
    }
    
    func cancelTapped(sender: UIButton) {
        _delegate?.cancelBookingTapped(sender: sender)
    }
}

extension MyBookingTableView: CompletedBookingDelegate {
    func reviewTapped(sender: UIButton) {
        _delegate?.reviewBookingTapped(sender: sender)
    }
}
