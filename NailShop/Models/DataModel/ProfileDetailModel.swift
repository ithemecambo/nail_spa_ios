//
//  ProfileDetailModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import MapKit
import Foundation

enum ProfileCellType: String {
    case banner
    case detail
    case specialist
    case about
    case openingHour
    case review
    case map
}

struct ProfileDetailModel: Codable {
    var id: UUID = UUID()
    var shopName: String?
    var bannerUrl: String?
    var address: String?
    var website: String?
    var tel: String?
    var latitude: Double?
    var longitude: Double?
    var share: String?
    var about: String?
    var status: Bool?
    var specialists: [NailArtModel]?
    var openingHours: [BusinessHourModel]?
    var reviews: [ReviewModel]?
    
    static var profile: ProfileDetailModel? {
        return ProfileDetailModel(shopName: "Bella Rinova",
                                  bannerUrl: "https://images.pexels.com/photos/998405/pexels-photo-998405.jpeg",
                                  address: "310 Steve Dr Unit 5 Russell Springs, KY 42642",
                                  website: "https://apple.com",
                                  tel: "775-230-8584",
                                  latitude: 37.0625119,
                                  longitude: -85.0725099,
                                  share: "https://apple.com",
                                  about: """
                                        Founded in 1995, Salon is an independent publication covering news and politics through a progressive, nonpartisan editorial lens, alongside our rigorous and inquisitive coverage of culture and entertainment, science and health, and food. Our editorial mission is pro-democracy, pro-equality and justice and pro-truth. We ask and seek to answer in good faith — through original reporting, news analysis, investigations, left-leaning and politically independent commentary, insightful cultural criticism, personal essays and in-depth interviews — big questions, such as:

                                        What is the state of democracy in the United States and the world?

                                        What are the most influential movements across the political spectrum, and where are they going next?

                                        Who are the most compelling cultural figures, what are the works that are defining this moment, and why?

                                        How did we get to this moment in entertainment, culture, food, science and public health? Where will — or should — we go next?

                                        Who is getting ahead in this moment, and who is being left behind or harmed?

                                        What political, cultural, scientific and food personalities, topics and movements are worth a deeper dive or a reconsideration?

                                        What challenges us in times of complacency? What soothes us in times of hardship?

                                        One of the first entirely digital major media outlets, Salon has driven the national conversation since 1995 through fearless journalism distributed across Salon.com, Salon TV, social media, news platforms, email newsletters and mobile apps. Salon’s award-winning content, including our flagship show “Salon Talks” and other Salon TV programming, reaches an audience of approximately 10 million monthly unique visitors.
                                        """,
                                  status: true,
                                  specialists: [NailArtModel(name: "Joely Viniier"), NailArtModel(name: "Jared Collier"), NailArtModel(name: "Hank Sokhonk"), NailArtModel(name: "Hort MouyCheng"), NailArtModel(name: "Oliver Xu")],
                                  openingHours: BusinessHourModel.openingHours,
                                  reviews: ReviewModel.reviews)
    }
}

struct BusinessHourModel: Codable {
    var id: UUID = UUID()
    var openingDay: String?
    var openingHour: String?
    
    static var openingHours: [BusinessHourModel] {
        return [
            BusinessHourModel(openingDay: "Tuesday - Friday", openingHour: "9:00AM - 0:00PM"),
            BusinessHourModel(openingDay: "Saturday", openingHour: "9:00AM - 6:00PM"),
            BusinessHourModel(openingDay: "Sunday", openingHour: "12:00AM - 5:00PM"),
            BusinessHourModel(openingDay: "Monday", openingHour: "Closed"),
        ]
    }
}

struct ReviewModel: Codable {
    var id: UUID = UUID()
    var fullName: String?
    var tel: String?
    var email: String?
    var rating: Int?
    var message: String?
    
    static var reviews: [ReviewModel]? {
        return [
            ReviewModel(fullName: "Oliver Xu", tel: "208-100-9091", email: "oliver.xu@dv.com", rating: 5, message: "Fast Service! I really like service related to nail & spa."),
            ReviewModel(fullName: "Joely Viniier", tel: "205-304-3848", email: "joely.viniier@gmail.com", rating: 4, message: "Great fast service! Very good for me and you"),
            ReviewModel(fullName: "Jared Collier", tel: "250-111-9292", email: "jared.collier@gmail.com", rating: 5, message: "Great Place! new material & clear."),
            ReviewModel(fullName: "Xavier Elum", tel: "102-399-4999", email: "xavierelum@dv.com", rating: 3, message: "Customer reviews are often unsolicited information left by your customer. They provide a quick summary of the customer's experience with your organization, product, or service."),
            ReviewModel(fullName: "David Rukity", tel: "250-300-3993", email: "david.rukity@gmail.com", rating: 4, message: "Wouldn't recommend. The quality is on par with cheaper competitors. (On that note, CompetitorPrint.com is cheap and good.) This was so bad that I tried to call the company when I got my order. The guy I spoke to, John Smith, only answered when I called him on his private line, 555 4545. He was polite and said I could get a refund but it's still poor value for money."),
            ReviewModel(fullName: "Alisa David", tel: "202-300-3999", email: "alisa.david@gmail.com", rating: 5, message: "The only reason not to give 5 stars is the fact that I had to separately claim for the offered cash back deal, rather than it being automatic, and this info wasn't stated anywhere."),
            ReviewModel(fullName: "John Sir", tel: "250-399-4004", email: "johnsir@gmail.com", rating: 2, message: "I'm happy with the phone and the deal I got from the company. I wanted a good smartphone that did the basics, and the site recommended one that ticked all the boxes. Speaking with the service team helped me get exactly what I was looking for."),
        ]
    }
}

class StoreAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(_ latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subtitle: String) {
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.title = title
        self.subtitle = subtitle
    }
}
