//
//  CompletedTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import UIKit

protocol CompletedBookingDelegate {
    func reviewTapped(sender: UIButton)
}

class CompletedTableViewCell: BaseTableViewCell {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var nailAvatarImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopAddressLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var reviewButton: UIButton!
    
    var delegate: CompletedBookingDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var completedViewModel: MyBookingModel? {
        didSet {
            guard let model = completedViewModel else { return }
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
    
    @IBAction func reviewButtonTapped(_ sender: UIButton) {
        delegate?.reviewTapped(sender: sender)
    }
}
