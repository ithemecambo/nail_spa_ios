//
//  ReviewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/24/23.
//

import Foundation

struct ApiReviewModel: Codable {
    var id: Int?             = 0
    var appointmentId: Int?  = 0
    var profileId: Int?      = 0
    var status: Bool?        = false
    var createdDate: String? = ""
    var updatedDate: String? = ""
    var ratingNum: Int?      = 0
    var comment: String?     = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case appointmentId = "appointment_id"
        case profileId = "profile_id"
        case status
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case ratingNum = "rating_num"
        case comment
    }
}

