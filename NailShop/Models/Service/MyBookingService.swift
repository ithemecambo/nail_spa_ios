//
//  MyBookingService.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/5/23.
//

import Foundation

protocol MyBookingService {
    func getMyBooking(profileId: Int, status: String, completed: @escaping (Result<[MyBookingModel]>) -> ())
    func cancelAppointment(appointmentId: Int, params: [String: Any], completed: @escaping (Result<ResponseAppointmentModel>) -> ())
    func rescheduleAppointment(appointmentId: Int, params: [String: Any], completed: @escaping (Result<ResponseAppointmentModel>) -> ())
    func createReview(params: [String: Any], completed: @escaping (Result<ApiReviewModel>) -> ())
}

class MockMyBookingService: MyBookingService {
    func getMyBooking(profileId: Int, status: String, completed: @escaping (Result<[MyBookingModel]>) -> ()) {
        HttpRequest.get(.v1, endPoint: "myBookings/\(profileId)/\(status)/") { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let bookings = try JSONDecoder().decode([MyBookingModel].self, from: data!)
                    completed(Result.success(bookings))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func cancelAppointment(appointmentId: Int, params: [String: Any], completed: @escaping (Result<ResponseAppointmentModel>) -> ()) {
        HttpRequest.put(.v1, endPoint: "cancel-appointment/\(appointmentId)/", parameters: params) { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let appointmentObj = try JSONDecoder().decode(ResponseAppointmentModel.self, from: data!)
                    completed(Result.success(appointmentObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func rescheduleAppointment(appointmentId: Int, params: [String: Any], completed: @escaping (Result<ResponseAppointmentModel>) -> ()) {
        HttpRequest.put(.v1, endPoint: "reschedule-appointment/\(appointmentId)/", parameters: params) { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let appointmentObj = try JSONDecoder().decode(ResponseAppointmentModel.self, from: data!)
                    completed(Result.success(appointmentObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func createReview(params: [String: Any], completed: @escaping (Result<ApiReviewModel>) -> ()) {
        HttpRequest.post(.v1, endPoint: "create-review/", parameters: params) { json, code, error in
            if error != nil {
                completed(Result.failed(json["message"].stringValue))
            } else {
                do {
                    let data = json.debugDescription.data(using: .utf8)
                    let reviewObj = try JSONDecoder().decode(ApiReviewModel.self, from: data!)
                    completed(Result.success(reviewObj))
                } catch let error {
                    completed(Result.failed(error.localizedDescription))
                }
            }
        }
    }
}
