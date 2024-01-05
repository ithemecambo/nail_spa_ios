//
//  AppointmentTableView.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/17/23.
//

import UIKit
import Foundation

protocol AppointmentTableViewDelegate {
    
}

protocol AppointmentTableViewDataSource {
    func appointmentData() -> MakeAppointmentModel?
}

class AppointmentTableView: UITableView {
    
    private var data: MakeAppointmentModel?
    var _delegate: AppointmentTableViewDelegate?
    var _dataSource: AppointmentTableViewDataSource?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTable()
    }
    
    override func reloadData() {
        data = _dataSource?.appointmentData()
        super.reloadData()
        let fromAnimation = AnimationType.from(direction: .left, offset: 120)
        UIView.animate(views: visibleCells, animations: [fromAnimation], duration: 0.4)
    }
    
    private func setupTable() {
        self.delegate       = self
        self.dataSource     = self
        self.separatorStyle = .none
        self.rowHeight      = UITableView.automaticDimension
        self.estimatedRowHeight = 100
        self.register(AppointmentTimeSlotTableViewCell.nib, forCellReuseIdentifier: AppointmentTimeSlotTableViewCell.identifier)
        self.register(AppointmentNailArtTableViewCell.nib, forCellReuseIdentifier: AppointmentNailArtTableViewCell.identifier)
        self.register(AppointmentServiceTableViewCell.nib, forCellReuseIdentifier: AppointmentServiceTableViewCell.identifier)
    }
}

extension AppointmentTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [data].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentTimeSlotTableViewCell.identifier, for: indexPath) as? AppointmentTimeSlotTableViewCell else { return UITableViewCell() }
            
            cell.timeSlotCollectionView.reloadData()
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentNailArtTableViewCell.identifier, for: indexPath) as? AppointmentNailArtTableViewCell else { return UITableViewCell() }
            
            cell.specialistCollectionView.reloadData()
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentServiceTableViewCell.identifier, for: indexPath) as? AppointmentServiceTableViewCell else { return UITableViewCell() }
            
            //cell.layoutIfNeeded()
            cell.serviceCollectionView.reloadData()
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension AppointmentTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0: return 580
            case 1: return 225
            default: return UITableView.automaticDimension
        }
    }
}
