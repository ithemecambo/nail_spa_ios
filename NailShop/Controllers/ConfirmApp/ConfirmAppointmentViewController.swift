//
//  ConfirmAppointmentViewController.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 12/5/23.
//

import UIKit
import SwiftyJSON
import MaterialComponents
import Alamofire

class ConfirmAppointmentViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bookingInfoView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var technicalNameLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var fullNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var phoneTextField: MDCOutlinedTextField!
    @IBOutlet weak var noteBodyView: UIView!
    @IBOutlet weak var checkIcon: UIImageView!
    @IBOutlet weak var termConditionLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var bookingView: UIView!
    @IBOutlet weak var bookingButton: UIButton!
    
    private var termCondition: Bool = true
    var viewModel: ConfirmAppointmentViewModel!
    var noteOfBookingTextArea: MDCOutlinedTextArea!
    private var router = DefualtConfirmAppointmentRouter()
    
    static func instantiate() -> ConfirmAppointmentViewController {
        let controller = Appointment.instantiateViewController(identifier: String(describing: self)) as! ConfirmAppointmentViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirm Appointment"
        self.setupLayout()
        setupAnimation()
        checkButton.isSelected = true
        guard let viewModel = viewModel else { return }
        viewModel.bindingView(self)
    }
    
    @IBAction func termButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            checkIcon.image = UIImage(systemName: "circle.inset.filled")
            termCondition = true
        } else {
            checkIcon.image = UIImage(systemName: "circle")
            termCondition = false
        }
    }
    
    @IBAction func bookingButtonTapped(_ sender: UIButton) {
        if !termCondition {
            self.alertMessage(message: "Please check the box to agree to the terms and conditions to continue.")
            return
        }
        guard let viewModel = viewModel else { return }
        self.startLoading(text: Loading)
        ThreadHelper.delay(dalay: 1.5) {
            let params = viewModel.makeAppointmentBody(self)
            viewModel.createMakeAppointment(params: params) { result in
                switch result {
                case .success(let data):
                    if data.id != nil {
                        viewModel.createBooking(CreateBookingModel(appointment_id: data.id ?? 0, packages: viewModel.services ?? [])) { result in
                            switch result {
                            case .success(let success):
                                if success {
                                    self.router.perform(.booking, from: self)
                                }
                                self.stopLoading()
                            case .failed(let error):
                                self.alertMessage(message: error)
                                self.stopLoading()
                            }
                        }
                    }
                case .failed(let error):
                    consoleLog(error)
                    self.stopLoading()
                }
            }
        }
    }
}

extension ConfirmAppointmentViewController {
    private func setupLayout() {
        fullNameTextField.label.text = "Full Name"
        fullNameTextField.setOutlineColor(.systemGray, for: .normal)
        fullNameTextField.setOutlineColor(.systemGreen, for: .editing)
        fullNameTextField.leadingView = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        fullNameTextField.leadingViewMode = .always
        
        phoneTextField.label.text = "Phone"
        phoneTextField.setOutlineColor(.systemGray, for: .normal)
        phoneTextField.setOutlineColor(.systemGreen, for: .editing)
        phoneTextField.leadingView = UIImageView(image: UIImage(systemName: "phone.circle.fill"))
        phoneTextField.leadingViewMode = .always
        var width: CGFloat = 0.0
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            width = UIScreen._width - 45
        } else {
            width = noteBodyView.frame.width - (UIScreen.main.bounds.height >= 812 ? -35: 20)
        }
        noteOfBookingTextArea = MDCOutlinedTextArea(frame: CGRect(x: 1, y: 5, width: width , height: noteBodyView.frame.height + 30))
        noteOfBookingTextArea.label.text = "Note"
        noteOfBookingTextArea.setOutlineColor(.systemGray, for: .normal)
        noteOfBookingTextArea.setOutlineColor(.systemGreen, for: .editing)
        noteOfBookingTextArea.minimumNumberOfVisibleRows = 3
        noteOfBookingTextArea.textView.font = .systemFont(ofSize: 14)
        noteBodyView.addSubview(noteOfBookingTextArea)
    }
    
    private func setupAnimation() {
        let fromAnimation = AnimationType.from(direction: .left, offset: 100)
        UIView.animate(views: [bookingInfoView, fullNameTextField, phoneTextField, noteBodyView, checkIcon, termConditionLabel, bookingView], animations: [fromAnimation], duration: 0.4)
    }
}
