//
//  ConfirmAppointmentViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/28/23.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

class ConfirmAppointmentViewModel {
    
    var date: String?
    var time: String?
    var profile: UserProfielModel?
    var nailArt: StaffMemberModel?
    var services: [PackageModel]?
    var serviceSelected: [String]?
    
    private var mockService = MockAppointmentService()
    
    required init(date: String?, time: String?, profile: UserProfielModel?, nailArt: StaffMemberModel?, services: [PackageModel]?, serviceSelected: [String]?) {
        self.date = date
        self.time = time
        self.profile = profile
        self.nailArt = nailArt
        self.services = services
        self.serviceSelected = serviceSelected
    }
    
    func bindingView(_ source: ConfirmAppointmentViewController) {
        source.dateTimeLabel.text = "\(date ?? ""), \(time ?? "")"
        source.technicalNameLabel.text = "\(nailArt?.user?.fullName ?? "") (\(nailArt?.nickName ?? ""))"
        serviceSelected?.count ?? 0 > 0 ? (source.serviceLabel.text = serviceSelected?.joined(separator: "\n")): (source.serviceLabel.text = "\n")
        
        source.phoneTextField.text = profile?.phone
        source.fullNameTextField.text = profile?.user?.fullName
    }
    
    func toJson() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["shop_id"] = 1
        dict["staff_id"] = 1
        dict["profile_id"] = 8
        dict["booking_day"] = date
        dict["booking_time"] = time
        dict["notes"] = "Healthy Nail"
        dict["appointment_status"] = "Upcoming"
        
        return dict
    }
    
    fileprivate func formattedDate(_ dateString: String) -> String {
        let simpleDateFormat = DateFormatter()
        simpleDateFormat.dateFormat = "EEEE, MMM d yyyy"
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        let date = simpleDateFormat.date(from: dateString)!
        return dateFormat.string(from: date)
    }
    
    func makeAppointmentBody(_ source: ConfirmAppointmentViewController) -> [String: Any] {
        var param: [String: Any] = [:]
        param["shop_id"] = 1
        param["staff_id"] = nailArt?.id
        param["profile_id"] = profile?.id
        param["booking_day"] = formattedDate(date ?? "")
        param["booking_time"] = time
        param["full_name"] = source.fullNameTextField.text ?? ""
        param["phone"] = source.phoneTextField.text ?? ""
        param["notes"] = source.noteOfBookingTextArea.textView.text ?? ""
        param["appointment_status"] = "Upcoming"
        
        return param
    }
    
    func bookingBody(_ appointmentId: Int) -> JSON {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try? encoder.encode(services)
        
        return JSON(String(data: data!, encoding: .utf8)!)
    }
    
    func createMakeAppointment(params: [String: Any], completed: @escaping (Result<MakeAppointmentModel>) -> ()) {
        mockService.createMakeAppointment(params: params) { result in
            switch result {
            case .success(let data):
                completed(Result.success(data))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func createBooking(_ payload: CreateBookingModel, completed: @escaping (Result<Bool>) -> ()) {
        mockService.createBooking(payload: payload) { result in
            switch result {
            case .success(let value):
                completed(Result.success(value))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
}
