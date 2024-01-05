//
//  UpcomingTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import UIKit

protocol UpcomingBookingDelegate {
    func enableNotificationTapped(sender: UISwitch)
    func alertNotificationTapped(sender: UIButton)
    func rescheduleTapped(sender: UIButton)
    func cancelTapped(sender: UIButton)
}

class UpcomingTableViewCell: BaseTableViewCell {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var nailAvatarImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopAddressLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var rescheduleLabel: UILabel!
    @IBOutlet weak var alertSwitch: UISwitch!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var rescheduleButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cancelViewTapped: UIView!
    
    var delegate: UpcomingBookingDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        alertSwitch.transform = CGAffineTransformMakeScale(0.70, 0.70)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var upcomingViewModel: MyBookingModel? {
        didSet {
            guard let model = upcomingViewModel else { return }
            dateTimeLabel.text = "\(formattedDate(model.appointmentId?.bookingDay ?? "")), \(model.appointmentId?.bookingTime ?? "")"
            model.appointmentId?.staffId?.photoUrl == "" ?
            (nailAvatarImageView.image = UIImage(named: "logo_brands")):
            (nailAvatarImageView.loadImage(url: "\(Configuration.baseUrl)\(model.appointmentId?.staffId?.photoUrl ?? "")"))
            shopNameLabel.text = model.appointmentId?.shopId?.shopName ?? ""
            shopAddressLabel.text = model.appointmentId?.shopId?.address ?? ""
            var services: [String] = []
            if model.packages.count > 0 {
                model.packages.forEach { service in
                    services.append(service.name ?? "")
                }
            }
            serviceLabel.text = "Services: \(services.joined(separator: ", "))"
        }
    }
    
    fileprivate func formattedDate(_ dateString: String) -> String {
        let simpleDateFormat = DateFormatter()
        simpleDateFormat.dateFormat = "yyyy-MM-dd"
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMMM d yyyy"
        
        let date = simpleDateFormat.date(from: dateString)!
        return dateFormat.string(from: date)
    }
    
    @IBAction func alertSwitchTapped(_ sender: UISwitch) {
        delegate?.enableNotificationTapped(sender: sender)
    }
    
    @IBAction func alertButtonTapped(_ sender: UIButton) {
        delegate?.alertNotificationTapped(sender: sender)
    }
    
    @IBAction func rescheduleButtonTapped(_ sender: UIButton) {
        delegate?.rescheduleTapped(sender: sender)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        delegate?.cancelTapped(sender: sender)
    }
}
