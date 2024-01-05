//
//  NotificationModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import Foundation

struct ApiNotificationModel: Codable {
    var status: Bool?       = false
    var result: [NotificationModel] = []
}

struct NotificationModel: Codable {
    var id: Int?            = 0
    var platformId: Int?   = 0
    var title: String?      = ""
    var subtitle: String?   = ""
    var message: String?    = ""
    var bannerUrl: String?  = ""
    var createdDate: String? = ""
    var updatedDate: String? = ""
    var status: Bool?       = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case platformId = "platform_id"
        case title
        case subtitle
        case message
        case bannerUrl = "photo_url"
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case status
    }
}

struct ScheduleAlertTimeModel: Codable {
    var id: UUID            = UUID()
    var displayTime: String = ""
    var valueOfTime: Int    = 0
    var isSelected: Bool    = false
    
    static var scheduleAlertTimes: [ScheduleAlertTimeModel] {
        return [
            ScheduleAlertTimeModel(id: UUID(), displayTime: "15 Mins", valueOfTime: 0, isSelected: false),
            ScheduleAlertTimeModel(id: UUID(), displayTime: "30 Mins", valueOfTime: 0, isSelected: false),
            ScheduleAlertTimeModel(id: UUID(), displayTime: "45 Mins", valueOfTime: 0, isSelected: true),
            ScheduleAlertTimeModel(id: UUID(), displayTime: "1 Hour", valueOfTime: 0, isSelected: false),
            ScheduleAlertTimeModel(id: UUID(), displayTime: "2 Hours", valueOfTime: 0, isSelected: false),
            ScheduleAlertTimeModel(id: UUID(), displayTime: "3 Hours", valueOfTime: 0, isSelected: false),
        ]
    }
}

struct DeviceModel: Codable {
    var id: Int?        = 0
    var platformName: String? = ""
    var uuid: String?   = ""
    var device: String? = ""
    var IPAddress: String?     = ""
    var createdDate: String? = ""
    var updatedDate: String? = ""
    var status: Bool?   = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case platformName = "platform_name"
        case uuid
        case device
        case IPAddress = "ip"
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case status
    }
}
