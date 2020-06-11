//
//  AddStudyVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/27.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper

class AddStudyVC: UIViewController {
    
    // MARK: - UI components
    
    let scrollView = UIScrollView()
    let containerView = UIView()

    let studyImageView = UIImageView().then {
        $0.image = UIImage(systemName: "camera")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }
    let addStudyImageButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.makeRounded(cornerRadius: 15)
        $0.tintColor = .white
        $0.backgroundColor = .signatureColor
        $0.contentMode = .scaleAspectFill
    }
    
    let studyTitleLabel = UILabel().then {
        $0.text = "스터디 제목"
        $0.sizeToFit()
        $0.font = Font.studyTitleLabel
    }
    let studyTitleTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
//        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let categoryLabel = UILabel().then {
            $0.text = "카테고리"
            $0.sizeToFit()
            $0.font = Font.studyContentsLabel
    }
    let categoryTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        //        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let introduceLabel = UILabel().then {
        $0.text = "소개"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let introduceTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        //        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let placeLabel = UILabel().then {
        $0.text = "장소"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let placeTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        //        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }

    let penaltyLabel = UILabel().then {
        $0.text = "스터디 벌금"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let penaltyYesButton = UIButton().then {
        $0.setTitle("있음", for: .normal)
        $0.makeRounded(cornerRadius: 17)
        $0.tintColor = .white
        $0.backgroundColor = .signatureColor
        $0.addTarget(self, action: #selector(didTapPenaltyYesButton), for: .touchUpInside)
    }
    let penaltyNoButton = UIButton().then {
        $0.setTitle("없음", for: .normal)
        $0.makeRounded(cornerRadius: 17)
        $0.tintColor = .white
        $0.backgroundColor = .signatureColor
        $0.addTarget(self, action: #selector(didTapPenaltyNoButton), for: .touchUpInside)
    }
    
    let penaltyView = UIView()
    let penaltyAttendanceLabel = UILabel().then {
        $0.text = "출석 벌금"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let penaltyAttendanceTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        //        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let penaltyLateLabel = UILabel().then {
        $0.text = "지각 벌금"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let penaltyLateTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        //        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let termLabel = UILabel().then {
        $0.text = "모집 기한"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let termYesButton = UIButton().then {
        $0.setTitle("있음", for: .normal)
        $0.makeRounded(cornerRadius: 17)
        $0.tintColor = .white
        $0.backgroundColor = .signatureColor
        $0.addTarget(self, action: #selector(didTapTermYesButton), for: .touchUpInside)
    }
    let termNoButton = UIButton().then {
        $0.setTitle("없음", for: .normal)
        $0.makeRounded(cornerRadius: 17)
        $0.tintColor = .white
        $0.backgroundColor = .signatureColor
        $0.addTarget(self, action: #selector(didTapTermNoButton), for: .touchUpInside)
    }
    
    let termView = UIView()
    let termStartLabel = UILabel().then {
        $0.text = "시작 날짜"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let termStartTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        //        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let termEndLabel = UILabel().then {
        $0.text = "종료 날짜"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let termEndTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        //        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let recruitLabel = UILabel().then {
        $0.text = "모집 인원"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let recruitTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        //        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    // MARK: - Variables and Properties
    
    var isClickedPenalty = false
    var isClickedTerm = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            title = "스터디"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "생성", style: .done, target: self, action: #selector(didTapCreateStudyButton))
            
            addSubView()
            makeConstraints()
            
            updatePenaltyStatus()
            updateTermStatus()
            
            containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContainerView)))
    //        createPickerView()
            
            
    //        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(didTapCancelButton))
        }
    
    // MARK: - Helper
    
    func updatePenaltyStatus() {
        if isClickedPenalty == true {
            penaltyYesButton.alpha = 1.0
            penaltyNoButton.alpha = 0.5
            
            penaltyView.alpha = 1.0
            penaltyView.isUserInteractionEnabled = true
        } else {
            penaltyYesButton.alpha = 0.5
            penaltyNoButton.alpha = 1.0
            
            penaltyView.alpha = 0.5
            penaltyView.isUserInteractionEnabled = false
        }
    }
    
    func updateTermStatus() {
        if isClickedTerm == true {
            termYesButton.alpha = 1.0
            termNoButton.alpha = 0.5
            
            termView.alpha = 1.0
            termView.isUserInteractionEnabled = true
        } else {
            termYesButton.alpha = 0.5
            termNoButton.alpha = 1.0
            
            termView.alpha = 0.5
            termView.isUserInteractionEnabled = false
        }
    }
    
    @objc func didTapPenaltyYesButton() {
        isClickedPenalty = true
        updatePenaltyStatus()
    }
    
    @objc func didTapPenaltyNoButton() {
        isClickedPenalty = false
        updatePenaltyStatus()
    }
    
    @objc func didTapTermYesButton() {
        isClickedTerm = true
        updateTermStatus()
    }
    
    @objc func didTapTermNoButton() {
        isClickedTerm = false
        updateTermStatus()
    }
    
//    private func createPickerView() {
//        // category picker
//        let categoryPickerView = UIPickerView()
//        categoryPickerView.delegate = self
//        categoryPickerView.dataSource = self
//        categoryTextField.inputView = categoryPickerView
//
//        // date picker
//        datePicker.datePickerMode = .date
//        startDateTextField.inputView = datePicker
//        endDateTextField.inputView = datePicker
//
//        // 공통 툴바
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        toolbar.tintColor = .signatureColor
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
//        toolbar.setItems([doneButton], animated: false)
//        toolbar.isUserInteractionEnabled = true
//        startDateTextField.inputAccessoryView = toolbar
//        endDateTextField.inputAccessoryView = toolbar
//        categoryTextField.inputAccessoryView = toolbar
//    }
//
//    @objc func dismissPickerView() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//        let date = dateFormatter.string(from: datePicker.date)
//
//        if startDateTextField.isEditing {
//            startDateTextField.text = date
//
//        } else if endDateTextField.isEditing {
//            endDateTextField.text = date
//        }
//
//        view.endEditing(true)
//    }
    
    @objc private func didTapContainerView() {
        self.view.endEditing(true)
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCreateStudyButton() {
//        self.createStudyService()
    }
   
//    @IBAction func didTapPenaltyButton(_ sender: Any) {
//        if penaltyTextField.isEnabled  {
//            penaltyButton.setTitle("", for: .normal)
//            penaltyTextField.isEnabled = !penaltyTextField.isEnabled
//            penaltyTextField.text = ""
//        } else {
//            penaltyButton.setTitle("✓", for: .normal)
//            penaltyTextField.isEnabled = !penaltyTextField.isEnabled
//        }
//    }
    
    
}

//extension AddStudyVC: UIPickerViewDelegate {}
//
//extension AddStudyVC: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return category.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        return category[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if category[row] == "카테고리" {
//            return
//        }
//        categoryTextField.text = category[row]
//    }
//
//}

// MARK: - 사용자 정보 서버 연결

//extension AddStudyVC {
//
//    func createStudyService() {
//        var chiefUserInfo: StudyUser?
//        chiefUserInfo?.id = KeychainWrapper.standard.integer(forKey: "id") ?? 0
//        chiefUserInfo?.name = KeychainWrapper.standard.string(forKey: "nickname") ?? ""
//        chiefUserInfo?.userID = KeychainWrapper.standard.string(forKey: "userID") ?? ""
//        chiefUserInfo?.image = KeychainWrapper.standard.string(forKey: "image") ?? ""
//
//        StudyService.shared.createStudy(token: KeychainWrapper.standard.string(forKey: "token") ?? "",
//                                        name: studyNameTextField.text ?? "",
//                                        image: "",
//                                        location: locationTextField.text ?? "",
//                                        content: explanationTextView.text ?? "",
//                                        userLimit: Int(headCountTextField.text ?? "0") ?? 0,
//                                        isFine: Bool(penaltyTextField.text ?? "false") ?? false,
//                                        isEnd: false,
//                                        chiefUser: chiefUserInfo!,
//                                        category: categoryTextField.text ?? "",
//                                        fine: penaltyTextField.text ?? "")() { result in
//
//            switch result {
//                case .success(let res):
//                    let responseResult = res as? Response
//                    simpleAlert(title: responseResult.m, message: <#T##String#>)
//
//                case .requestErr(_):
//                    print(".requestErr")
//                case .pathErr:
//                    print(".pathErr")
//                case .serverErr:
//                    print(".serverErr")
//                case .networkFail:
//                    print(".networkFail")
//            }
//
//        }
//    }
//
//}
