//
//  AppointmentViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/13/23.
//

import UIKit
import FSCalendar
import SwiftyJSON

class AppointmentViewController: BaseViewController {

    @IBOutlet weak var tableView: AppointmentTableView!
    @IBOutlet weak var collectionView: AppointmentCollectionView! {
        didSet {
            self.collectionView._delegate   = self
            self.collectionView._dataSource = self
        }
    }
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var makeAppointmentView: UIView!
    
    private var router = DefaultAppointmentRouter()
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
    fileprivate lazy var onlyNumDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    fileprivate lazy var fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d yyyy"
        return formatter
    }()
    fileprivate lazy var hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    private var today = Date().addingTimeInterval(-24*60*60)
    private (set) var selectedDate: Bool = false
    private (set) var selectedTime: Bool = false
    private (set) var selectedNailArt: Bool = false
    
    private (set) var yourDate: String = ""
    private (set) var yourTime: String = ""
    private (set) var currentNumDay: String = ""
    private (set) var userProfile: UserProfielModel!
    private (set) var yourFavNail: StaffMemberModel!
    private (set) var yourServices: [PackageModel] = []
    private (set) var yourServiceSelected: [String] = []
    
    private var viewModel = AppointmentViewModel()
    private var appointmentData: SectionAppointmentModel?
    
    static func instantiate() -> AppointmentViewController {
        let controller = Main.instantiateViewController(withIdentifier: String(describing: self)) as! AppointmentViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Appointment"
        self.makeAppointmentView.alpha = selectedNailArt ? 1: 0
        self.collectionView.contentInset.bottom = selectedNailArt ? 65 : 0
        let day = self.onlyDayDateFormatter.string(from: Date())
        self.currentNumDay = self.onlyNumDayDateFormatter.string(from: Date())
        self.validateNoData()
        if day != "Monday" {
            self.fetchData()
        }
        if !selectedDate && !selectedTime && !selectedNailArt {
            self.availableScheduleForBooking(day, date: Date())
        }
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        self.calenderView.setCurrentPage(getPreviousMonth(date: calenderView.currentPage), animated: true)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        calenderView.setCurrentPage(getNextMonth(date: calenderView.currentPage), animated: true)
    }
    
    @IBAction func makeAppointmentButtonTapped(_ sender: UIButton) {
        if selectedDate && selectedTime && selectedNailArt {
            guard let yourFavNail = yourFavNail, 
                    let userProfile = UserProfielModel.getProfile() else { return }
            self.router.perform(.makeAppointment(yourDate, yourTime,
                                                 userProfile, yourFavNail,
                                                 yourServices, yourServiceSelected), from: self)
        } else {
            self.alertMessage(message: "Please select data, time, and staff member.")
        }
    }
    
    deinit {
        consoleLog("\(#function)")
    }
}

extension AppointmentViewController {
    fileprivate func availableScheduleForBooking(_ currentDay: String, date: Date) {
        let numDay = self.onlyNumDayDateFormatter.string(from: Date())
        let hour = NSCalendar.current.component(.hour, from: Date())
        let day = self.onlyDayDateFormatter.string(from: date)
        if currentDay == day {
            switch day {
            case "Monday":
                checkWeekOfMonday(today: currentDay)
                return
            case "Saturday", "Sunday":
                if numDay == self.currentNumDay {
                    switch hour {
                    case 11...17: self.sameDayAlertMessage()
                        return
                    case 18...24: self.sorryAlertMessage()
                        return
                    default: break
                    }
                }
                checkWeekOfMonday(today: currentDay)
            default:
                if numDay == self.currentNumDay {
                    switch hour {
                    case 11...19: self.sameDayAlertMessage()
                        return
                    case 20...24: self.sorryAlertMessage()
                        return
                    default: break
                    }
                }
                checkWeekOfMonday(today: currentDay)
            }
        } else {
            checkWeekOfMonday(today: currentDay)
        }
    }
    
    fileprivate func checkWeekOfMonday(today: String) {
        if today == "Monday" {
            collectionView.isUserInteractionEnabled = false
            self.alertMessage(title: "Shop Closed Every Monday", message: "No time slot available. Please pick another date. If you need help with booking, please call us at (270) 866-3389")
            self.collectionView.setContentOffset(.zero, animated: false)
            self.makeAppointmentView.alpha = 0
        } else {
            self.fetchDataByWeekDay(today)
            if selectedTime && selectedNailArt {
                self.makeAppointmentView.alpha = 1
            }
            collectionView.didAllowSelectRowByTime = true
            collectionView.isUserInteractionEnabled = true
        }
    }
    
    fileprivate func sorryAlertMessage() {
        collectionView.isUserInteractionEnabled = false
        self.alertMessage(title: "😭SORRY⏰😭", message: "No time slot available. Please pick another date. If you need help with booking, please call us at (270) 866-3389")
    }
    
    fileprivate func sameDayAlertMessage() {
        self.alertMessage(title: "⏰SORRY😫", message: "Same date appointment is not available. please call us at (270) 866-3389 to ask about booking.")
    }
    
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
    
    fileprivate func fetchData() {
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.main.async(group: group) {
            self.fetchDataByWeekDay(self.onlyDayDateFormatter.string(from: Date()))
            group.leave()
        }
        group.enter()
        DispatchQueue.main.async(group: group) {
            self.getProfile(8)
            group.leave()
        }
        group.notify(queue: DispatchQueue.global()) {
            consoleLog("----- Downloaded")
        }
    }
    
    fileprivate func fetchDataByWeekDay(_ searchByDay: String) {
        self.collectionView.removeNoData()
        viewModel.getAppointmentByWeekDays(searchByDay) { result in
            switch result {
            case .success(let data):
                self.appointmentData = data
            case .failed(let error):
                self.alertMessage(message: error)
            }
            self.validateNoData()
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func getProfile(_ id: Int) {
        viewModel.getProfile(id: id) { result in
            switch result {
            case .success(let user):
                self.userProfile = user
            case .failed(let error):
                self.alertMessage(message: error)
            }
        }
    }
    
    fileprivate func validateNoData() {
        guard let timeSlots = self.appointmentData?.timeSlots else { return }
        if timeSlots[0].timeSlots.count == 0 {
            self.collectionView.noData(message: "There are no current time slot for today.", fileName: "no-time-slot")
        } else {
            self.collectionView.removeNoData()
        }
    }
    
    fileprivate func getNextMonth(date: Date) -> Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to: date)!
    }

    fileprivate func getPreviousMonth(date: Date) -> Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to: date)!
    }
}

extension AppointmentViewController: AppointmentCollectionViewDataSource {
    func appointmentItemData() -> SectionAppointmentModel? {
        return appointmentData
    }
}

extension AppointmentViewController: AppointmentCollectionViewDelegate {
    func didSelect(index: IndexPath) {
        
    }
    
    func didSelectByTimeSlot(index: Int) {
        if self.selectedDate {
            self.selectedTime = true
            let timeSlots = appointmentData?.timeSlots[0].timeSlots
            self.yourTime = timeSlots?[index].time ?? ""
            self.collectionView.didAllowSelectRowByTime = true
            self.collectionView.didAllowSelectRowByNailArt = true
        } else {
            self.alertMessage(message: "Please select date that you want to make an appointment.")
        }
    }
    
    func didSelectByNailArt(index: Int) {
        if self.selectedDate && self.selectedTime {
            self.selectedNailArt = true
            self.makeAppointmentView.alpha = 1
            let nailArts = appointmentData?.nailSpecialists
            self.yourFavNail = nailArts?[index]
            self.collectionView.contentInset.bottom = selectedNailArt ? 65: 0
        } else {
            self.alertMessage(message: "Please select date and time that you want to make an appointment.")
        }
    }
    
    func addServiced(index: Int) {
        if selectedDate && selectedTime && selectedNailArt {
            self.router.perform(.selectedService(yourServices), from: self)
        } else {
            self.alertMessage(message: "Please select data, time, and staff member.")
        }
    }
}

extension AppointmentViewController: SheetServiceSaveDataDelegate {
    func saveDataCompleted(items: [PackageModel]) {
        yourServices = items
        yourServiceSelected = []
        collectionView.performBatchUpdates {
            self.collectionView.reloadSections(IndexSet(integer: 2))
        } completion: { finish in
            if (finish) {
                var resultString: [String] = []
                items.forEach { service in
                    resultString.append("• \(service.name?.capitalized ?? "")")
                    self.yourServiceSelected.append("• \(service.name?.capitalized ?? "")")
                }
                guard let cell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 2)) as? EmptyServiceCollectionViewCell else { return }
                cell.serviceLabel.text = self.yourServiceSelected.joined(separator: "\n")
                //resultString.joined(separator: "\n")
                self.collectionView.setContentOffset(.zero, animated: false)
            }
        }
    }
}

extension AppointmentViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        consoleLog("did select date \(self.dateFormatter.string(from: date))")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        currentNumDay = self.onlyNumDayDateFormatter.string(from: date)
        consoleLog("currentNumDay: \(currentNumDay)")
        let day = self.onlyDayDateFormatter.string(from: date)
        yourDate = self.fullDateFormatter.string(from: date)
        self.availableScheduleForBooking(day, date: date)
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
