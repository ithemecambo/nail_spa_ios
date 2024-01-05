//
//  Configuration.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import Foundation

struct Configuration {
    #if DEV_ENVIRONMENT
        static let apiPath = "http://127.0.0.1:8000/api/v1/"
        static let apiPath2 = "http://127.0.0.1:8000/api/v1/"

    #else
        static let apiPath = "https://senghort.pythonanywhere.com/api/v1/"
        static let apiPath2 = "https://senghort.pythonanywhere.com/api/v1/"
    #endif
    
    static let baseUrl = "https://senghort.pythonanywhere.com"
}
