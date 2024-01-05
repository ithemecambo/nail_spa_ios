//
//  ResheduleBookingViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/24/23.
//

import SwiftyJSON
import Foundation

class ResheduleBookingViewModel {
    
    private var mockService = MockAppointmentService()
    var appointment: YourAppointmentModel?
    
    required init(appointment: YourAppointmentModel?) {
        self.appointment = appointment
    }
    
    func getAppointmentByWeekDays(_ keyword: String, completed: @escaping (Result<[TimeSlotModel]>) -> ()) {
        mockService.getAppointmentByWeekDays(keyword: keyword) { result in
            switch result {
            case .success(let data):
                if data.timeSlots.count > 0 {
                    completed(Result.success(data.timeSlots[0].timeSlots))
                } else {
                    completed(Result.failed("Something was wrong [index of out an array]."))
                }
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func rescheduleAppointment(appointmentId: Int, params: [String: Any], completed: @escaping (Result<MakeAppointmentModel>) -> ()) {
        mockService.rescheduleAppointment(appointmentId: appointmentId, params: params) { result in
            switch result {
            case .success(let appointment):
                completed(Result.success(appointment))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func rescheduleBody(selectDate: String, selectTime: String) -> [String: Any] {
        var param: [String: Any] = [:]
        param["booking_day"] = formattedDate(selectDate)
        param["booking_time"] = selectTime
        param["appointment_status"] = "Pending"
        
        return param
    }
    
    fileprivate func formattedDate(_ dateString: String) -> String {
        let simpleDateFormat = DateFormatter()
        simpleDateFormat.dateFormat = "EEEE, MMM d yyyy"
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        let date = simpleDateFormat.date(from: dateString)!
        return dateFormat.string(from: date)
    }
}
