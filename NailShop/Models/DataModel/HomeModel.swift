//
//  HomeModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit
import Foundation

struct HomeResponse<T: Codable>: Codable {
    var id: UUID = UUID()
    var type: HomeType?
    var data: [T]
}

struct HomeModel: Codable {
    
    var id: Int?            = 0
    var shopName: String?  = ""
    var tel: String?        = ""
    var fax: String?        = ""
    var email: String?      = ""
    var website: String?    = ""
    var twitter: String?    = ""
    var facebook: String?   = ""
    var linkedin: String?   = ""
    var instagram: String?  = ""
    var address: String?    = ""
    var latitude: Double?   = 0.0
    var longitude: Double?  = 0.0
    var bannerUrl: String? = ""
    var logoUrl: String?   = ""
    var about: String?      = ""
    var promotions: [PromotionModel]? = []
    var staffMembers: [StaffMemberModel]?  = []
    var services: [PackageModel]? = []
    var galleries: [GalleryModel]? = []
    var businessOpenHours: [BusinessOpenHourModel]? = []
    
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
        case promotions
        case staffMembers = "staffs"
        case services
        case galleries
        case businessOpenHours = "business_hours"
    }
    
    static func toJson(model: HomeModel) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try? encoder.encode(model)
        consoleLog(String(data: data!, encoding: .utf8)!)
    }
}

struct PromotionModel: Codable {
    var id: Int?            = 0
    var shopId: Int?       = 0
    var serviceId: Int?    = 0
    var title: String?      = ""
    var subtitle: String?   = ""
    var discount: CGFloat?  = 0.0
    var photoUrl: String?  = ""
    var color: String?      = ""
    var status: Bool?       = false
    var createdDate: String? = ""
    var updatedDate: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case shopId = "shop_id"
        case serviceId = "service_id"
        case title
        case subtitle
        case discount
        case photoUrl = "photo_url"
        case color
        case status
        case createdDate = "created_at"
        case updatedDate = "updated_at"
    }
}

struct GalleryModel: Codable {
    var id: Int?            = 0
    var photoUrl: String?   = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case photoUrl = "photo_url"
    }
}

struct BusinessOpenHourModel: Codable {
    var id: Int?            = 0
    var day: String?        = ""
    var hour: String?       = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case day
        case hour
    }
}

struct ApiPromotionModel: Codable {
    var id: UUID = UUID()
    var promotions: [PromotionModel]?
}

struct ApiNailArtModel: Codable {
    var id: UUID = UUID()
    var nailArts: [NailArtModel]?
}

struct NailArtModel: Codable {
    var id: UUID = UUID()
    var name: String?
    var avatar: String?
    var tel: String?
    var email: String?
    var specialist: String?
    var rating: Float?
    var color: String?
    
    static var nailArts: [NailArtModel] {
        return [
            NailArtModel(name: "Joely Viniier", rating: 4.3, color: "#FFCDD2"),
            NailArtModel(name: "Sade Adu", rating: 3.7, color: "#7986CB"),
            NailArtModel(name: "Mary Magdalene", rating: 5.0, color: "#42A5F5"),
            NailArtModel(name: "Emmanuel", rating: 4.3, color: "#4DD0E1"),
            NailArtModel(name: "Samuel Ling", rating: 3.5, color: "#4CAF50"),
            NailArtModel(name: "Charles Sahra", rating: 4.5, color: "#D4E157"),
            NailArtModel(name: "Mario Joao", rating: 3.7, color: "#FFC107"),
            NailArtModel(name: "Tatyana Mark", rating: 5.0, color: "#FF8A65"),
            NailArtModel(name: "Natalya Qing", rating: 4.5, color: "#80D8FF"),
            NailArtModel(name: "Andrey Christine", rating: 5.0, color: "#00ACC1"),
        ]
    }
}

struct ApiServiceModel: Codable {
    var id: UUID = UUID()
    var services: [Service]?
}

struct Service: Codable {
    var id: UUID = UUID()
    var name: String?
    var icon: String?
    var items: [ServiceItemModel]?
    var isExpanded: Bool = false
    var type: ServiceType? = .healthyNail
    
    static var services: [Service] {
        return [
            Service(name: "Healthy Nail", icon: "healthy-nails.jpeg", items: ServiceItemModel.serviceForHealthyNail, isExpanded: true, type: .healthyNail),
            Service(name: "Nail Enhancement", icon: "nail-enhancement.jpeg", items: ServiceItemModel.serviceForNailEnhancement, type: .nailEnhancement),
            Service(name: "Manicure", icon: "manicure.jpeg", items: ServiceItemModel.serviceForManicure, type: .manicure),
            Service(name: "Pedicure", icon: "pedicure.jpg", items: ServiceItemModel.serviceForPedicure, type: .pedicure),
            Service(name: "Additional Service", icon: "additional-service.jpg", items: ServiceItemModel.serviceAdditional, type: .additionalService),
        ]
    }
}

struct ServiceItemModel: Codable, Equatable {
    var id: UUID = UUID()
    var name: String?
    var icon: String?
    var price: String?
    var selected: Bool = false
    var description: String?
    
    static func ==(lhs: ServiceItemModel, rhs: ServiceItemModel) -> Bool {
        return  lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.icon == rhs.icon &&
            lhs.price == rhs.price &&
            lhs.selected == rhs.selected &&
            lhs.description == rhs.description
    }
    
    static var serviceItems: [ServiceItemModel] {
        return [
            ServiceItemModel(name: "Ladies Haircutting Services", description: "Get the perfect look! With the help of our expert stylists. Each haircut comes with a complimentary consultation to find the right style for your hair texture, face shape, and much more."),
            ServiceItemModel(name: "Waxing Service", description: "Waxing is a type of hair removal utilizing depilatory wax to remove unwanted hair, leaving a manicured appearance of the treated area."),
            ServiceItemModel(name: "Glitter-lites hair tinsel", description: "Hair Tinsel is a way to add sparkle to your look. We use professional tinsel curated to withstand heat up to 400 degrees, color resistant. You can have this for one sparkling night, or wear up to 3 months. We have a variety of colors to choose from guaranteeing you will find your sparkle! You may add this after a color service or just by itself. Starting price is $25 depending on how many strands you choose. Each returning time will be half off given you have 50% of tinsel left in hair."),
            ServiceItemModel(name: "Hair Treatment Services", description: "We focus on the most important treatments, moisture, repairing, shine and scalp, and use only the best products like Olaplex. Customize your today by clicking Book now. Cancelation/No Show Fees Apply."),
            ServiceItemModel(name: "Senior Set Services", description: "Our Senior Sets are for our mature customers that like to come weekly for a style. Choose your preference."),
            ServiceItemModel(name: "Toner or Glaze Service", description: "Toner/Glaze services, includes Customized Color application Haircut and Style. This service is perfect for pre existing blonde or refreshing and adding shine to the color you have now. Prices are subject to change with length and/or thickness of hair, Cancelation/No Show fees apply."),
            ServiceItemModel(name: "30 Minute Maintenance Facials", description: "Our 30-minute facials are designed for maximum cleansing, exfoliation, and hydration for our busy, on-the-go clients who are looking for simple but results-driven treatment. Each 30-minute facial is focused on enhancing and maintaining the skin. Cancellation/No Show Fees Apply."),
            ServiceItemModel(name: "Brow Tinting", description: "Brow tinting is an affordable, temporary solution for those who want to enhance their brows but aren't ready or do not want to commit to a treatment like microblading. It involves the application of semi-permanent or permanent hair color to the brows as a way to darken, or change the color."),
            ServiceItemModel(name: "Formal Styles", description: "Complete any Special Occasion with our Formal Style Service. Perfect for Pictures, Prom, Weddings, or any event you want to make a statement and look your best. Book now by customizing the look you want. Cancelation/No Show Fee Applies."),
            ServiceItemModel(name: "Make-Up Application", description: "Our stylist, are expert artists, when it comes to getting you all dolled up for a formal event, photo shoot, or wedding, we will use just the right products to create the perfect customized look that enhances your natural beauty.  From everyday Basic to full on Event Glam we have options for everyone."),
            ServiceItemModel(name: "60 Minute Custom Targeting Facial", description: "Every 60-minute facial at The Main Event Salon includes a professional cleanse, exfoliation, muscle-stimulating massage of face, neck and shoulder, Custom Hydro Jelly Peel, with optional targeting treatments add Ons with oxygen, steam, lite therapy and more, all customized for you. Cancelation/No Show Fees Apply")
        ]
    }
    
    static var serviceForHealthyNail: [ServiceItemModel] {
        return [
            ServiceItemModel(name: "SNS PINK AND WHITE WITH MANICURE", price: "$48", selected: false),
            ServiceItemModel(name: "SNS PINK AND WHITE", price: "$40", selected: false),
            ServiceItemModel(name: "SNS COLOR WITH MANICURE", price: "$43"),
            ServiceItemModel(name: "SNS COLOR", price: "$35"),
        ]
    }
    
    static var serviceForNailEnhancement: [ServiceItemModel] {
        return [
            ServiceItemModel(name: "SOLAR (PINK & WHITE)", price: "$58"),
            ServiceItemModel(name: "PINK AND WHITE FILL IN", price: "$45+", selected: false),
            ServiceItemModel(name: "PINK FILL", price: "$25+"),
            ServiceItemModel(name: "SOLAR NAIL (OMBRE)", price: "$65"),
            ServiceItemModel(name: "POWDER GEL FULL SET", price: "$35"),
            ServiceItemModel(name: "REGULAR ACRYLIC (FULL-SET)", price: "$28+"),
            ServiceItemModel(name: "REGULAR ACRYLIC (FILL)", price: "$18+"),
            ServiceItemModel(name: "ACRYLIC ON TOENAIL SET", price: "$50"),
            ServiceItemModel(name: "ACRYLIC ON TOENAIL FILL", price: "$35"),
            ServiceItemModel(name: "UV GEL FULL SET", price: "$50"),
            ServiceItemModel(name: "UV GEL FILL", price: "$35"),
            ServiceItemModel(name: "UV GEL PINK & WHITE FULL SET", price: "$65"),
            ServiceItemModel(name: "UV GEL PINK & WHITE FILL", price: "$48"),
            ServiceItemModel(name: "POWDER GEL FILL IN", price: "$25"),
        ]
    }
    
    static var serviceForManicure: [ServiceItemModel] {
        return [
            ServiceItemModel(name: "MANICURE + SHELLAC GEL COLOR", price: "$35", description: "Add $5 for French or Amie"),
            ServiceItemModel(name: "DELUXE MANICURE", price: "$35", description: "Massage hot stone with sea salt (exfoliate skin), mask, warm towels, soft butter, polish, drip dry and paraffin wax."),
            ServiceItemModel(name: "CANDLE SPA MANICURE", price: "$30", description: "Longer massage with candle, oil, 2 hot stone and polish."),
            ServiceItemModel(name: "SPA MANICURE", price: "$25", description: "Massage With honey sugar wrap, hot stone, mask and warm towel and polish."),
            ServiceItemModel(name: "MANICURE +", price: "$20", description: "Massage with oil and polish"),
            ServiceItemModel(name: "REGULAR MANICURE", price: "$15"),
        ]
    }
    
    static var serviceForPedicure: [ServiceItemModel] {
        return [
            ServiceItemModel(name: "DELUXE SPA PEDICURE", price: "$45", description: "(Nail Trim, shaping, cuticle, remove callous). Massage sea salt your dead skin), 4 hot stone, mask, warm towel, soft butter, polish, drip dry and paraffin wax."),
            ServiceItemModel(name: "CANDLE SPA PEDICURE", price: "$42", description: "(Nail Trim. shaping, cuticle, remove callous). Longer Massage (20 minute) with candle, massage oil, 6 hot stone, and polish."),
            ServiceItemModel(name: "SPA PEDICURE", price: "$35", description: "(Nail Trim. shaping, cuticle, remove callous). Massage honey sugar wrap with 4 hot stone, mask, warm towel, massage oil, polish."),
            ServiceItemModel(name: "PEDICURE +", price: "$30", description: "(Nail trim, shaping, cuticle, callous). Massage with oil, 2 hot stone and polish."),
            ServiceItemModel(name: "BASIC PEDICURE", price: "$25", description: "(Nail trim, shaping, cuticle, callous). Massage with lotion and polish)"),
        ]
    }
    
    static var serviceAdditional: [ServiceItemModel] {
        return [
            ServiceItemModel(name: "POLISH CHANGE HAND", price: "$7"),
            ServiceItemModel(name: "POLISH CHANGE HAND FRENCH", price: "$10"),
            ServiceItemModel(name: "POLISH CHANGE FEET", price: "$10"),
            ServiceItemModel(name: "POLISH CHANGE FEET FRENCH", price: "$12"),
            ServiceItemModel(name: "TOP GEL SUPER SHINE", price: "$5"),
            ServiceItemModel(name: "CUT DOWN", price: "$2"),
            ServiceItemModel(name: "NAIL REPAIR", price: "$5+"),
            ServiceItemModel(name: "NAILS REPAIR WILL FILL", price: "$3+"),
            ServiceItemModel(name: "NAIL ART FOT TWO", price: "$5+"),
            ServiceItemModel(name: "FRENCH OR AMERICAN TIP", price: "$5"),
            ServiceItemModel(name: "ACRYLIC TAKE OFF", price: "$15+"),
            ServiceItemModel(name: "GEL POLISH CHANGE HAND", price: "$20"),
            ServiceItemModel(name: "GEL POLISH CHANGE FEET", price: "$25"),
        ]
    }
}

struct ApiGalleryModel: Codable {
    var id: UUID = UUID()
    var galleries: [GalleryModel]?
}

struct ApiBusinessHourModel: Codable {
    var id: UUID = UUID()
    var businessHours: [BusinessHourModel]?
}
