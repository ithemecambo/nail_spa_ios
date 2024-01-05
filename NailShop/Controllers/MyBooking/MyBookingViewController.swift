//
//  MyBookingViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/14/23.
//

import UIKit

class MyBookingViewController: BaseViewController {
    
    @IBOutlet weak var bookingSegment: WMSegment!
    @IBOutlet weak var tableView: MyBookingTableView! {
        didSet {
            self.tableView._delegate    = self
            self.tableView._dataSource  = self
        }
    }
    private var bookings: [MyBookingModel] = []
    private var viewModel = MyBookingViewModel()
    private var router = DefaultMyBookingRouter()
    
    static func instantiate() -> MyBookingViewController {
        let controller = Main.instantiateViewController(withIdentifier: String(describing: self)) as! MyBookingViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Booking"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.shared.delete()
        self.myBooking()
    }
    
    @IBAction func bookingSegmentTapped(_ sender: WMSegment) {
        if sender.selectedSegmentIndex == 0 {
            // Load booking by `Upcoming`
            self.myBooking("Upcoming")
        } else if sender.selectedSegmentIndex == 1 {
            // Load booking by `Completed`
            self.myBooking("Completed")
        }
    }
    
    fileprivate func myBooking(_ status: String = "Upcoming") {
        guard let profile = UserProfielModel.getProfile() else { return }
        self.tableView.removeNoData()
        self.startLoading(text: Loading)
        ThreadHelper.delay(dalay: 0.1) {
            self.viewModel.getMyBooking(profileId: profile.id ?? 0, status: status) { result in
                switch result {
                case .success(let bookings):
                    self.bookings = bookings
                    self.stopLoading()
                case .failed(let error):
                    self.stopLoading()
                    self.alertMessage(message: error)
                }
                self.validateNoData(status)
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func validateNoData(_ status: String) {
        if self.bookings.count == 0 {
            if status == "Upcoming" {
                self.tableView.noData(message: "There currently are no \(status.lowercased()) \nbooking yet.", fileName: "no-appointment")
            } else if status == "Completed" {
                self.tableView.noData(message: "There currently are no \(status.lowercased()) \nbooking yet.", fileName: "no-booking")
            }
        } else {
            self.tableView.removeNoData()
        }
    }
}

extension MyBookingViewController: MyBookingTableViewDataSource {
    func myBookings() -> [MyBookingModel] {
        return bookings
    }
}

extension MyBookingViewController: MyBookingTableViewDelegate {
    func enableNotificationTapped(sender: UISwitch) {
        
    }
    
    func alertNotificationTapped(sender: UIButton) {
        self.router.perform(.scheduleAlertNotification, from: self)
    }
    
    func rescheduleBookingTapped(sender: UIButton) {
        guard let appointment = bookings[sender.tag].appointmentId else { return }
        self.router.perform(.reschedule(appointment), from: self)
    }
    
    func cancelBookingTapped(sender: UIButton) {
        self.alertMessage(message: "Are you sure, you want to cancel of your booking?", titleButton: "Yes", titleButton2: "No", action:  {
            guard let appointment = self.bookings[sender.tag].appointmentId else { return }
            self.startLoading(text: Loading)
            self.viewModel.cancelAppointment(appointmentId: appointment.id ?? 0) { result in
                ThreadHelper.delay(dalay: 1.0) {
                    switch result {
                    case .success(_):
                        self.stopLoading()
                        self.myBooking("Upcoming")
                    case .failed(let error):
                        self.stopLoading()
                        self.alertMessage(message: error)
                    }
                }
            }
        }) {
            consoleLog("No cancelled of booking.")
        }
    }
    
    func reviewBookingTapped(sender: UIButton) {
        let booking = bookings[sender.tag]
        viewModel.showSubmitCommentPopup(parent: self, data: booking) { commentText, rating in
            self.viewModel.createReview(params: self.viewModel.reviewBody(
                    appointmentId: booking.appointmentId?.id ?? 0,
                    profileId: booking.appointmentId?.profileId?.id ?? 0,
                    ratingNum: Int(rating), comment: commentText)) { result in
                self.startLoading(text: Loading)
                ThreadHelper.delay(dalay: 0.5) {
                    switch result {
                    case .success(_):
                        self.stopLoading()
                    case .failed(let error):
                        self.stopLoading()
                        self.alertMessage(message: error)
                    }
                }
            }
        }
    }
}

extension MyBookingViewController: RescheduleBookingViewDelegate {
    func didReload() {
        self.alertMessage(message: "Your an appointment was rescheduled. We will review by sending a notification as soon. Thank you for using our app for make an appointment.") {
            self.myBooking("Upcoming")
        }
    }
}
