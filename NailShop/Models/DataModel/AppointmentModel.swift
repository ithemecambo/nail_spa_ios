//
//  AppointmentModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit
import Foundation

struct SectionAppointmentModel: Codable {
    var timeSlots: [WeekDayModel] = []
    var nailSpecialists: [StaffMemberModel] = []
    var services: [ServiceModel] = []
    
    enum CodingKeys: String, CodingKey {
        case timeSlots = "time_slots"
        case nailSpecialists = "nail_specialists"
        case services
    }
}

struct WeekDayModel: Codable {
    var id: Int?          = 0
    var weekDay: String?  = ""
    var timeSlots: [TimeSlotModel] = []
    var isBooking: Bool?  = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case weekDay = "week_day"
        case timeSlots = "time_slots"
        case isBooking = "is_booking"
    }
    
    func toJSON(model: WeekDayModel) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try? encoder.encode(model)
        consoleLog(String(data: data!, encoding: .utf8)!)
    }
}

struct TimeSlotModel: Codable {
    var id: Int?        = 0
    var time: String?   = ""
    var status: Bool?   = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case time
        case status
    }
}

struct MakeAppointmentModel: Codable {
    var id: Int?            = 0
    var shopId: Int?        = 0
    var staffId: Int?       = 0
    var profileId: Int?     = 0
    var bookingDay: String? = ""
    var bookingTime: String? = ""
    var amount: CGFloat?    = 0.0
    var notes: String?      = ""
    var status: Bool?       = false
    var appointmentStatus: String? = ""
    var createdDate: String? = ""
    var updatedDate: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case shopId = "shop_id"
        case staffId = "staff_id"
        case profileId = "profile_id"
        case bookingDay = "booking_day"
        case bookingTime = "booking_time"
        case amount
        case notes
        case status
        case appointmentStatus = "appointment_status"
        case createdDate = "created_at"
        case updatedDate = "updated_at"
    }
}

struct CreateBookingModel: Codable {
    var appointment_id: Int? = 0
    var packages: [PackageModel]? = []
}

struct CreateAppointmentBody: Codable {
    var shop_id: Int = 0
    var staff_id: Int = 0
    var profile_id: Int = 0
    var booking_day: String = ""
    var booking_time: String = ""
    var full_name: String = ""
    var phone: String = ""
    var notes: String = ""
    var appointment_status: String = ""
    
    static func toJson(model: CreateAppointmentBody) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try? encoder.encode(model)
        consoleLog(String(data: data!, encoding: .utf8)!)
    }
}
