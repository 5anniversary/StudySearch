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

    let categoryPickerView = UIPickerView()
    let termDatePicker = UIDatePicker()
    
    let studyImageView = UIImageView().then {
        $0.image = UIImage(systemName: "camera")
        $0.setRounded(radius: 50)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }
    let addStudyImageButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.makeRounded(cornerRadius: 15)
        $0.tintColor = .white
        $0.backgroundColor = .signatureColor
        $0.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(didTapAddStudyImageButton), for: .touchUpInside)
    }
    let studyImagePicker = UIImagePickerController()
    
    let studyTitleLabel = UILabel().then {
        $0.text = "스터디 제목"
        $0.sizeToFit()
        $0.font = Font.studyTitleLabel
    }
    let studyTitleTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.addTarget(self, action: #selector(CreateWeekVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let categoryLabel = UILabel().then {
        $0.text = "카테고리"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let categoryTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.addTarget(self, action: #selector(CreateWeekVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let introduceLabel = UILabel().then {
        $0.text = "소개"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    lazy var introduceTextView = UITextView().then {
        $0.sizeToFit()
        $0.isScrollEnabled = false
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5) // 기본 설정 값인 0이 좌우 여백이 있기 때문에 조정 필요
        $0.allowsEditingTextAttributes = true
        $0.adjustsFontForContentSizeCategory = true
        $0.delegate = self
    }
    let underLineView = UIView().then {
        $0.backgroundColor = .signatureColor
    }
    
    let placeLabel = UILabel().then {
        $0.text = "장소"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let placeTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.addTarget(self, action: #selector(CreateWeekVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
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
        $0.addTarget(self, action: #selector(CreateWeekVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let penaltyLateLabel = UILabel().then {
        $0.text = "지각 벌금"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let penaltyLateTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.addTarget(self, action: #selector(CreateWeekVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let penaltyHomeworkLabel = UILabel().then {
        $0.text = "과제 벌금"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let penaltyHomeworkTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.addTarget(self, action: #selector(CreateWeekVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
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
        $0.addTarget(self, action: #selector(CreateWeekVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let termEndLabel = UILabel().then {
        $0.text = "종료 날짜"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let termEndTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.addTarget(self, action: #selector(CreateWeekVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let userLimitLabel = UILabel().then {
        $0.text = "모집 인원"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }
    let userLimitTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.keyboardType = .numberPad
        $0.addTarget(self, action: #selector(CreateWeekVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    // MARK: - Variables and Properties
    
    var isClickedPenalty = false
    var isClickedTerm = false
    
    var isTextFieldFilled = false
    var isTextViewFilled = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studyImagePicker.delegate = self
        
        title = "스터디"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "생성", style: .done, target: self, action: #selector(didTapCreateStudyButton))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        addSubView()
        makeConstraints()
        
        addKeyboardNotification()
        
        setStudyImageClickActions()
        
        createPickerView()
        
        updatePenaltyStatus()
        updateTermStatus()
        
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContainerView)))
    }
    
    // MARK: - Helper
    
    func updatePenaltyStatus() {
        if isClickedPenalty == true {
            penaltyYesButton.alpha = 1.0
            penaltyNoButton.alpha = 0.5
            
            penaltyView.alpha = 1.0
            penaltyView.isUserInteractionEnabled = true
            
            // call textfieldDidChange(studyTitleTextField는 해당 함수를 호출하기 위한 예시)
            textFieldDidChange(studyTitleTextField)
        } else {
            penaltyYesButton.alpha = 0.5
            penaltyNoButton.alpha = 1.0
            
            penaltyView.alpha = 0.5
            penaltyView.isUserInteractionEnabled = false
            
            penaltyAttendanceTextField.text = ""
            penaltyLateTextField.text = ""
            penaltyHomeworkTextField.text = ""
            
            // call textfieldDidChange(studyTitleTextField는 해당 함수를 호출하기 위한 예시)
            textFieldDidChange(studyTitleTextField)
        }
    }
    
    func updateTermStatus() {
        if isClickedTerm == true {
            termYesButton.alpha = 1.0
            termNoButton.alpha = 0.5
            
            termView.alpha = 1.0
            termView.isUserInteractionEnabled = true
            
            // call textfieldDidChange(studyTitleTextField는 해당 함수를 호출하기 위한 예시)
            textFieldDidChange(studyTitleTextField)
        } else {
            termYesButton.alpha = 0.5
            termNoButton.alpha = 1.0
            
            termView.alpha = 0.5
            termView.isUserInteractionEnabled = false
            
            termStartTextField.text = ""
            termEndTextField.text = ""
            
            // call textfieldDidChange(studyTitleTextField는 해당 함수를 호출하기 위한 예시)
            textFieldDidChange(studyTitleTextField)
        }
    }
    
    func setStudyImageClickActions() {
        studyImageView.tag = 1
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(studyImageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        studyImageView.isUserInteractionEnabled = true
        studyImageView.addGestureRecognizer(tapGestureRecognizer1)
    }
    
    @objc func studyImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let imgView = tapGestureRecognizer.view as! UIImageView
        //Give your image View tag
        if (imgView.tag == 1) {
            didTapAddStudyImageButton()
        }
    }
    @objc func didTapAddStudyImageButton() {
        let studyImageAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        studyImageAlert.view.tintColor = .signatureColor
        
        let albumAction = UIAlertAction(title: "앨범에서 스터디 사진 선택", style: .default) { action in
            self.openLibrary()
        }
        let cameraAction = UIAlertAction(title: "카메라로 스터디 사진 찍기", style: .default) { action in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        studyImageAlert.addAction(albumAction)
        studyImageAlert.addAction(cancel)
        
        if (UIImagePickerController .isSourceTypeAvailable(.camera)) {
            studyImageAlert.addAction(cameraAction)
        }
        
        present(studyImageAlert, animated: true)
    }

   // MARK: - Actions
   
   @objc private func didTapContainerView() {
       self.view.endEditing(true)
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
   
   @objc private func didTapCancelButton() {
       self.dismiss(animated: true, completion: nil)
   }
   
   @objc private func didTapCreateStudyButton() {
       //        self.createStudyService()
   }

    // MARK: - Picker View
    
    private func createPickerView() {
        // picker setting
        //        _ = categoryPickerView.then {
        //            $0.delegate = self
        //            $0.dataSource = self
        //        }
        _ = termDatePicker.then {
            $0.datePickerMode = .date
            $0.locale = Locale(identifier: "ko")
        }
        
        // set picker
        categoryTextField.inputView = categoryPickerView
        
        termDatePicker.datePickerMode = .date
        termStartTextField.inputView = termDatePicker
        termEndTextField.inputView = termDatePicker
        
        // common toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = .signatureColor
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(dismissPickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        categoryTextField.inputAccessoryView = toolbar
        termStartTextField.inputAccessoryView = toolbar
        termEndTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissPickerView() {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyy.MM.dd"
        }
        
        let selectedDate = dateFormatter.string(from: termDatePicker.date)
        if termStartTextField.isEditing {
            termStartTextField.text = selectedDate
            
        } else if termEndTextField.isEditing {
            termEndTextField.text = selectedDate
        }
        
        view.endEditing(true)
    }
    
    // MARK: - Keyboard Mangement
    
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height + 20, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

        let current = view.getSelectedTextField()
        let currentSelectTextFieldDownPos = (current?.frame.origin.y ?? 0) + (current?.frame.size.height ?? 0)
        scrollView.setContentOffset(CGPoint(x: 1, y: currentSelectTextFieldDownPos), animated: true)
        scrollView.scrollRectToVisible(categoryLabel.frame, animated: true)
        var rect = self.view.frame
        rect.size.height -= keyboardFrame.height
        if rect.contains(introduceTextView.frame.origin) {
            scrollView.scrollRectToVisible(introduceTextView.frame, animated: true)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
}

// MARK: - 스터디 이미지 선택 창 전환 기능 구현
extension AddStudyVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openLibrary(){
        studyImagePicker.sourceType = .photoLibrary
        
        present(studyImagePicker, animated: true, completion: nil)
    }
    func openCamera(){
        studyImagePicker.sourceType = .camera
        
        present(studyImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            studyImageView.image = image
            studyImageView.contentMode = .scaleAspectFill
        }
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - 카테고리 리스트 표시

//extension AddStudyVC: UIPickerViewDelegate {}
//
//extension AddStudyVC: UIPickerViewDataSource {
//
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

// MARK: - 입력 텍스트 값 변화 감지 Delegate

extension AddStudyVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        var str = introduceTextView.text.replacingOccurrences(of: " ", with: "")
        str = str.replacingOccurrences(of: "\n", with: "")
        
        if str.count != 0 {
            isTextViewFilled = true
        } else {
            isTextViewFilled = false
        }
        
        // TextField와 TextView의 입력조건 충족 동시 확인
        if isTextFieldFilled == true && isTextViewFilled == true {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
}

extension AddStudyVC: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        // 입력된 빈칸 감지하기
        var titleStr = studyTitleTextField.text
        var categoryStr = categoryTextField.text
        var placeStr = placeTextField.text
        titleStr = titleStr?.replacingOccurrences(of: " ", with: "")
        categoryStr = categoryStr?.replacingOccurrences(of: " ", with: "")
        placeStr = placeStr?.replacingOccurrences(of: " ", with: "")
        
        var attendancePenaltyStr: String?
        var latePenaltyStr: String?
        var homeworkPenaltyStr: String?
        if isClickedPenalty == true {
            attendancePenaltyStr = penaltyAttendanceTextField.text
            latePenaltyStr = penaltyLateTextField.text
            homeworkPenaltyStr = penaltyHomeworkTextField.text
            
            attendancePenaltyStr = attendancePenaltyStr?.replacingOccurrences(of: " ", with: "")
            latePenaltyStr = latePenaltyStr?.replacingOccurrences(of: " ", with: "")
            homeworkPenaltyStr = homeworkPenaltyStr?.replacingOccurrences(of: " ", with: "")
        }
        
        var termStartStr: String?
        var termEndStr: String?
        if isClickedTerm == true {
            termStartStr = termStartTextField.text
            termEndStr = termEndTextField.text
            
            termStartStr = termStartStr?.replacingOccurrences(of: " ", with: "")
            termEndStr = termEndStr?.replacingOccurrences(of: " ", with: "")
        }
        
        var userLimitStr = userLimitTextField.text
        userLimitStr = userLimitStr?.replacingOccurrences(of: " ", with: "")
        
        
        // 벌금, 기한 유무 버튼 on/off에 따른 빈칸 조건 검사 범위 조정
        if isClickedPenalty == true && isClickedTerm == true {
            // 벌금, 기한 모두 설정 하였을 때(텍스트 필드 전부 검사)
            if titleStr?.count != 0 &&
                categoryStr?.count != 0 &&
                placeStr?.count != 0 &&
                
                attendancePenaltyStr?.count != 0 &&
                latePenaltyStr?.count != 0 &&
                homeworkPenaltyStr?.count != 0 &&
                
                termStartStr?.count != 0 &&
                termEndStr?.count != 0 &&
                
                userLimitStr?.count != 0 {
                
                isTextFieldFilled = true
            } else {
                isTextFieldFilled = false
            }
            
        } else {
            
            if isClickedPenalty == true {
                // 벌금만 설정 하였을 때(기한을 제외하고 검사)
                if titleStr?.count != 0 &&
                    categoryStr?.count != 0 &&
                    placeStr?.count != 0 &&
                    
                    attendancePenaltyStr?.count != 0 &&
                    latePenaltyStr?.count != 0 &&
                    homeworkPenaltyStr?.count != 0 &&
                    
                    userLimitStr?.count != 0 {
                    
                    isTextFieldFilled = true
                } else {
                    isTextFieldFilled = false
                }
                
            } else if isClickedTerm == true {
                // 기한만 설정 하였을 때(벌금을 제외하고 검사)
                if titleStr?.count != 0 &&
                    categoryStr?.count != 0 &&
                    placeStr?.count != 0 &&
                    
                    termStartStr?.count != 0 &&
                    termEndStr?.count != 0 &&
                    
                    userLimitStr?.count != 0 {
                    
                    isTextFieldFilled = true
                } else {
                    isTextFieldFilled = false
                }
                
            } else {
                // 벌금, 기한 모두 설정하지 않았을 때(벌금, 기한 모두 제외하고 검사)
                if titleStr?.count != 0 &&
                    categoryStr?.count != 0 &&
                    placeStr?.count != 0 &&
                    
                    userLimitStr?.count != 0 {
                    
                    isTextFieldFilled = true
                } else {
                    isTextFieldFilled = false
                }
            }
        }
        
        
        // TextField와 TextView의 입력조건 충족 동시 확인
        if isTextFieldFilled == true && isTextViewFilled == true {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
}

// MARK: - 사용자 정보 서버 연결

extension AddStudyVC {

    func createStudyService() {
        var chiefUserInfo: StudyUser?
        chiefUserInfo?.id = KeychainWrapper.standard.integer(forKey: "id") ?? 0
        chiefUserInfo?.name = KeychainWrapper.standard.string(forKey: "nickname") ?? ""
        chiefUserInfo?.userID = KeychainWrapper.standard.string(forKey: "userID") ?? ""
        chiefUserInfo?.image = KeychainWrapper.standard.string(forKey: "image") ?? ""
        
        var fineInfo: Fine?
        fineInfo?.attendance = Int(penaltyAttendanceTextField.text ?? "0") ?? 0
        fineInfo?.tardy = Int(penaltyLateTextField.text ?? "0") ?? 0
        fineInfo?.assignment = Int(penaltyHomeworkTextField.text ?? "0") ?? 0

        StudyService.shared.createStudy(token: KeychainWrapper.standard.string(forKey: "token") ?? "",
                                        name: studyTitleTextField.text ?? "",
                                        image: "",
                                        location: placeTextField.text ?? "",
                                        content: introduceTextView.text ?? "",
                                        userLimit: Int(userLimitTextField.text ?? "0") ?? 0,
                                        isFine: isClickedPenalty,
                                        isEnd: false,
                                        isDate: isClickedTerm,
                                        startDate: termStartTextField.text ?? "0000.00.00",
                                        endDate: termEndTextField.text ?? "0000.00.00",
                                        chiefUser: chiefUserInfo!,
                                        category: "IT",
                                        fine: fineInfo!) { result in

            switch result {
                case .success(let res):
                    let responseStudyCreate = res as! Response
                    
                    switch responseStudyCreate.status {
                        case 200:
                            self.navigationController?.popViewController(animated: true)
                        
                        case 400, 406, 411, 500, 420, 421, 422, 423:
                            self.simpleAlert(title: responseStudyCreate.message, message: "")
                            
                        default:
                            self.simpleAlert(title: "오류가 발생하였습니다", message: "")
                    }

                case .requestErr(_):
                    print(".requestErr")
                case .pathErr:
                    print(".pathErr")
                case .serverErr:
                    print(".serverErr")
                case .networkFail:
                    print(".networkFail")
            }

        }
    }

}
