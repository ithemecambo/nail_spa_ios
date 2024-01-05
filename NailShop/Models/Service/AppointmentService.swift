//
//  AppointmentService.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import SwiftyJSON
import Alamofire
import Foundation

protocol AppointmentService {
    func getAppointmentByWeekDays(keyword: String, completed: @escaping (Result<SectionAppointmentModel>) -> ())
    func createMakeAppointment(params: [String: Any], completed: @escaping (Result<MakeAppointmentModel>) -> ())
    func createBooking(payload: CreateBookingModel, completed: @escaping (Result<Bool>) -> ())
    func createBooking(params: [String: Any], completed: @escaping (Result<String>) -> ())
    func rescheduleAppointment(appointmentId: Int, params: [String: Any], completed: @escaping (Result<MakeAppointmentModel>) -> ())
}

class MockAppointmentService: AppointmentService {
    func getAppointmentByWeekDays(keyword: String, completed: @escaping (Result<SectionAppointmentModel>) -> ()) {
        HttpRequest.get(.v1, endPoint: "getAppointmentByWeekDays/\(keyword)/") { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let appObj = try JSONDecoder().decode(SectionAppointmentModel.self, from: data!)
                    completed(Result.success(appObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func createMakeAppointment(params: [String: Any], completed: @escaping (Result<MakeAppointmentModel>) -> ()) {
        HttpRequest.post(.v1, endPoint: "appointment/", parameters: params) { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let makeAppObj = try JSONDecoder().decode(MakeAppointmentModel.self, from: data!)
                    completed(Result.success(makeAppObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func createBooking(params: [String: Any], completed: @escaping (Result<String>) -> ()) {
        HttpRequest.post(.v1, endPoint: "booking/", parameters: params) { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let successString = try JSONDecoder().decode(String.self, from: data!)
                    completed(Result.success(successString))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func createBooking(payload: CreateBookingModel, completed: @escaping (Result<Bool>) -> ()) {
        AF.request("\(Configuration.apiPath)booking/", method: .post, parameters: payload, encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(_):
                    completed(Result.success(true))
                case let .failure(error):
                    completed(Result.failed(error.localizedDescription))
                }
        }
    }
    
    func rescheduleAppointment(appointmentId: Int, params: [String: Any], completed: @escaping (Result<MakeAppointmentModel>) -> ()) {
        HttpRequest.put(.v1, endPoint: "reschedule-appointment/\(appointmentId)/", parameters: params) { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let appointmentObj = try JSONDecoder().decode(MakeAppointmentModel.self, from: data!)
                    completed(Result.success(appointmentObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
}
