//
//  MyBookingViewModel.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/16/23.
//

import UIKit
import Foundation
import PopupDialog

class MyBookingViewModel {
    
    private var mockService = MockMyBookingService()
    
    func getMyBooking(profileId: Int, status: String, completed: @escaping (Result<[MyBookingModel]>) -> ()) {
        mockService.getMyBooking(profileId: profileId, status: status) { result in
            switch result {
            case .success(let bookings):
                completed(Result.success(bookings))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func cancelAppointment(appointmentId: Int, completed: @escaping (Result<ResponseAppointmentModel>) -> ()) {
        mockService.cancelAppointment(appointmentId: appointmentId, params: ["appointment_status": "Cancelled"]) { result in
            switch result {
            case .success(let appointment):
                completed(Result.success(appointment))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func rescheduleAppointment(appointmentId: Int, params: [String: Any], completed: @escaping (Result<ResponseAppointmentModel>) -> ()) {
        mockService.cancelAppointment(appointmentId: appointmentId, params: params) { result in
            switch result {
            case .success(let appointment):
                completed(Result.success(appointment))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func showSubmitCommentPopup(parent: UIViewController,
                                data: MyBookingModel,
                                submitAction: @escaping (String, Double) -> ()) {
        let controller = ReviewViewController.instantiate()
        let popup = PopupDialog(viewController: controller,
                                buttonAlignment: .horizontal,
                                tapGestureDismissal: false,
                                panGestureDismissal: false)
        popup.transitionStyle = .zoomIn
        controller.feelingLabel.text = "How do you feel about our service that we had provided by `\(data.appointmentId?.staffId?.user?.fullName ?? "")`?"
        
        let cancelButton = CancelButton(title: "CANCEL", height: 50) {
            consoleLog("You canceled the rating dialog")
        }
        let submitButton = DefaultButton(title: "SUBMIT", height: 50) {
            submitAction(controller.commentTextArea.textView.text ?? "", controller.ratingView.rating)
        }
        submitButton.buttonColor = UIColor.systemGreen
        submitButton.titleColor = UIColor.white
        popup.addButtons([cancelButton, submitButton])
        
        parent.present(popup, animated: true, completion: nil)
    }
    
    func createReview(params: [String: Any], completed: @escaping (Result<ApiReviewModel>) -> ()) {
        mockService.createReview(params: params) { result in
            switch result {
            case .success(let review):
                completed(Result.success(review))
            case .failed(let error):
                completed(Result.failed(error))
            }
        }
    }
    
    func reviewBody(appointmentId: Int, profileId: Int, ratingNum: Int, comment: String) -> [String: Any] {
        var param: [String: Any] = [:]
        param["appointment_id"] = appointmentId
        param["profile_id"] = profileId
        param["rating_num"] = ratingNum
        param["comment"] = comment
        
        return param
    }
}
