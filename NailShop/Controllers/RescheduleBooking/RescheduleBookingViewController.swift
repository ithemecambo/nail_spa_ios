//
//  RescheduleBookingViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/24/23.
//

import UIKit
import FSCalendar
import SwiftyJSON

protocol RescheduleBookingViewDelegate {
    func didReload()
}

class RescheduleBookingViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: RescheduleTableView! {
        didSet {
            self.collectionView._delegate   = self
            self.collectionView._dataSource = self
        }
    }
    
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var makeAppointmentView: UIView!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var onlyDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    fileprivate lazy var fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d yyyy"
        return formatter
    }()
    
    private (set) var yourDate: String = ""
    private (set) var yourTime: String = ""
    private var timeSlots: [TimeSlotModel] = []
    private (set) var selectedDate: Bool = false
    private (set) var selectedTime: Bool = false
    private var today = Date().addingTimeInterval(-24*60*60)
    
    var viewModel: ResheduleBookingViewModel!
    
    var delegate: RescheduleBookingViewDelegate?
    
    static func instantiate() -> RescheduleBookingViewController {
        let controller =  Appointment.instantiateViewController(withIdentifier: String(describing: self)) as! RescheduleBookingViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        let day = self.onlyDayDateFormatter.string(from: Date())
        if day != "Monday" {
            self.fetchDataByWeekDay(day)
        }
        self.makeAppointmentView.alpha = selectedTime ? 1: 0
        self.collectionView.contentInset.bottom = selectedTime ? 65 : 0
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        self.calenderView.setCurrentPage(getPreviousMonth(date: calenderView.currentPage), animated: true)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        calenderView.setCurrentPage(getNextMonth(date: calenderView.currentPage), animated: true)
    }
    
    @IBAction func makeAppointmentButtonTapped(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        let params = viewModel.rescheduleBody(selectDate: self.yourDate, selectTime: self.yourTime)
        viewModel.rescheduleAppointment(appointmentId: viewModel.appointment?.id ?? 0,
                                        params: params) { result in
            self.startLoading(text: Loading)
            ThreadHelper.delay(dalay: 0.5) {
                switch result {
                case .success(let data):
                    consoleLog("Appointment: \(data)")
                    self.stopLoading()
                    self.delegate?.didReload()
                    self.dismiss(animated: true)
                case .failed(let error):
                    self.stopLoading()
                    self.alertMessage(message: error)
                }
            }
        }
    }
}

extension RescheduleBookingViewController {
    fileprivate func setupUI() {
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        self.selectedDate = false
        self.calenderView.scope = .week
        self.calenderView.appearance.headerTitleColor = .systemGreen
        self.calenderView.appearance.weekdayTextColor = .systemGreen
        self.calenderView.appearance.todayColor = .clear
        self.calenderView.appearance.headerMinimumDissolvedAlpha = 0
        self.calenderView.appearance.eventSelectionColor = .systemGreen
        self.calenderView.appearance.selectionColor = .systemGreen
    }
    
    fileprivate func fetchDataByWeekDay(_ searchByDay: String) {
        guard let viewModel = viewModel else { return }
        viewModel.getAppointmentByWeekDays(searchByDay) { result in
            switch result {
            case .success(let data):
                self.timeSlots = data
            case .failed(let error):
                self.alertMessage(message: error)
            }
            self.collectionView.reloadData()
        }
    }
    
    func getNextMonth(date: Date) -> Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to: date)!
    }

    func getPreviousMonth(date: Date) -> Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to: date)!
    }
}

extension RescheduleBookingViewController: RescheduleTableViewDelegate {
    func didSelectByTimeSlot(index: Int) {
        if self.selectedDate {
            self.selectedTime = true
            let timeSlots = timeSlots
            self.makeAppointmentView.alpha = 1
            self.yourTime = timeSlots[index].time ?? ""
            self.collectionView.didAllowSelectRowByTime = true
        } else {
            self.alertMessage(message: "Please select date that you want to make an appointment.")
        }
    }
}

extension RescheduleBookingViewController: RescheduleTableViewDataSource {
    func timeSlotItemLists() -> [TimeSlotModel]? {
        return timeSlots
    }
}

extension RescheduleBookingViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        consoleLog("did select date \(self.dateFormatter.string(from: date))")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        let day = self.onlyDayDateFormatter.string(from: date)
        if day == "Monday" {
            collectionView.isUserInteractionEnabled = false
            self.alertMessage(title: "Shop Closed Every Monday", message: "No time slot available. Please pick another date. If you need help with booking, please call us at (270) 866-3389")
            self.collectionView.setContentOffset(.zero, animated: false)
            self.makeAppointmentView.alpha = 0
        } else {
            self.fetchDataByWeekDay(day)
            if selectedTime {
                self.makeAppointmentView.alpha = 1
            }
            yourDate = self.fullDateFormatter.string(from: date)
            collectionView.isUserInteractionEnabled = true
            collectionView.didAllowSelectRowByTime = true
        }
        self.selectedDate = true
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if date < today {
            return false
        } else {
            return true
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if date < today {
            return .lightGray
        } else {
            return UIColor(named: "textColor")
        }
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        consoleLog("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
}
