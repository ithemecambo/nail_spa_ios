//
//  MyBookingModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import UIKit
import Foundation

struct ShopMakeAppointmentModel: Codable {
    var id: Int?                = 0
    var shopName: String?       = ""
    var tel: String?            = ""
    var fax: String?            = ""
    var email: String?          = ""
    var website: String?        = ""
    var twitter: String?        = ""
    var facebook: String?       = ""
    var linkedin: String?       = ""
    var instagram: String?      = ""
    var address: String?        = ""
    var latitude: Double?       = 0.0
    var longitude: Double?      = 0.0
    var bannerUrl: String?      = ""
    var logoUrl: String?        = ""
    var about: String?          = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case shopName = "shop_name"
        case tel
        case fax
        case email
        case website
        case twitter
        case facebook
        case linkedin
        case instagram
        case address
        case latitude
        case longitude
        case bannerUrl = "banner_url"
        case logoUrl = "logo_url"
        case about
    }
}

struct YourAppointmentModel: Codable {
    var id: Int?                = 0
    var shopId: ShopMakeAppointmentModel? = nil
    var staffId: StaffMemberModel?  = nil
    var profileId: UserProfielModel? = nil
    var status: Bool            = false
    var createdDate: String?    = ""
    var updatedDate: String?    = ""
    var bookingDay: String?     = ""
    var bookingTime: String?    = ""
    var fullName: String?       = ""
    var phone: String?          = ""
    var amount: CGFloat?        = 0.0
    var notes: String?          = ""
    var appointmentStatus: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case shopId = "shop_id"
        case staffId = "staff_id"
        case profileId = "profile_id"
        case status
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case bookingDay = "booking_day"
        case bookingTime = "booking_time"
        case fullName = "full_name"
        case phone
        case amount
        case notes
        case appointmentStatus = "appointment_status"
    }
}

struct MyBookingModel: Codable {
    var id: Int?                = 0
    var status: Bool?           = false
    var createdDate: String?    = ""
    var updatedDate: String?    = ""
    var packages: [PackageModel] = []
    var appointmentId: YourAppointmentModel? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case packages
        case appointmentId = "appointment_id"
    }
}

struct ResponseAppointmentModel: Codable {
    var id: Int?            = 0
    var shopId: Int?        = 0
    var staffId: Int?       = 0
    var profileId: Int?     = 0
    var fullName: String?   = ""
    var phone: String?      = ""
    var bookingDay: String? = ""
    var bookingTime: String? = ""
    var amount: CFloat?     = 0.0
    var createdDate: String? = ""
    var updatedDate: String? = ""
    var notes: String?      = ""
    var status: Bool?       = false
    var appointmentStatus: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case shopId = "shop_id"
        case staffId = "staff_id"
        case profileId = "profile_id"
        case fullName = "full_name"
        case phone
        case bookingDay = "booking_day"
        case bookingTime = "booking_time"
        case amount
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case notes
        case status
        case appointmentStatus = "appointment_status"
    }
}
