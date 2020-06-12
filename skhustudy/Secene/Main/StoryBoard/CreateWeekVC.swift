//
//  CreateWeekVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then

import SwiftKeychainWrapper

class CreateWeekVC: UIViewController {
    
    // MARK: - View
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
    }
    let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
    }
    
    let chapterTitleLabel = UILabel().then {
        $0.text = "챕터 제목"
        $0.sizeToFit()
        $0.font = Font.studyTitleLabel
    }
    
    let chapterTitleTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
//        $0.keyboardType = .numberPad
    }
    
    let placeLabel = UILabel().then {
        $0.text = "장소"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }

    let placeTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
    }
    
    let dateLabel = UILabel().then {
        $0.text = "날짜"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }

    let dateTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.keyboardType = .numberPad
    }

    let chapterContentLabel = UILabel().then {
        $0.text = "챕터 내용"
        $0.sizeToFit()
        $0.font = Font.studyContentsLabel
    }

    let chapterContentTextView = UITextView().then {
        $0.sizeToFit()
        $0.isScrollEnabled = false
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5) // 기본 설정 값인 0이 좌우 여백이 있기 때문에 조정 필요
        $0.allowsEditingTextAttributes = true
        $0.adjustsFontForContentSizeCategory = true
    }
    let underLineView = UIView().then {
        $0.backgroundColor = .signatureColor
    }
    
    let bookingButton = UIButton().then {
        $0.setTitle("스페이스 클라우드에서\n예약하기", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.titleLabel?.lineBreakMode = .byWordWrapping
        $0.titleLabel?.textAlignment = .center
        $0.makeRounded(cornerRadius: 23)
        $0.tintColor = .white
        $0.backgroundColor = .purple
    }
    
    // MARK: - Variables and Properties
    
    var studyID: Int = 0
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "챕터 생성"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "생성", style: .done, target: self, action: #selector(didTapAddWeekButton))
        
//        addKeyboardNotification()
//        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContainerView)))
        
//        setDatePicker()
        addSubView()
        makeConstraints()
    }
    
    // MARK: Methods
//
//    func addKeyboardNotification() {
//         NotificationCenter.default.addObserver(
//             self,
//             selector: #selector(keyboardWillShow),
//             name: UIResponder.keyboardWillShowNotification,
//             object: nil)
//
//         NotificationCenter.default.addObserver(
//             self,
//             selector: #selector(keyboardWillHide),
//             name: UIResponder.keyboardWillHideNotification,
//             object: nil)
//
//     }

//     @objc func keyboardWillShow(_ notification: Notification) {
//        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//
//         let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
//         scrollView.contentInset = contentInsets
//         scrollView.scrollIndicatorInsets = contentInsets
//
//         var rect = self.view.frame
//         rect.size.height -= keyboardFrame.height
//         if rect.contains(memoTextView.frame.origin) {
//             scrollView.scrollRectToVisible(memoTextView.frame, animated: true)
//         }
//     }
//
//     @objc func keyboardWillHide(_ notification: Notification) {
//         let contentInsets = UIEdgeInsets.zero
//         scrollView.contentInset = contentInsets
//         scrollView.scrollIndicatorInsets = contentInsets
//     }
//
//    private func setDatePicker() {
//        dateTextField.inputView = datePicker
//        let date = Date()
//        let stringDate = dateFormatter.string(from: date)
//        dateTextField.text = stringDate
//
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        toolbar.tintColor = .signatureColor
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
//        toolbar.setItems([doneButton], animated: false)
//        toolbar.isUserInteractionEnabled = true
//
//        dateTextField.inputAccessoryView = toolbar
//
//    }
//
//    @objc private func didTapContainerView() {
//        self.view.endEditing(true)
//    }
//
//
//    @objc private func dismissPickerView() {
//        let date = dateFormatter.string(from: datePicker.date)
//        dateTextField.text = date
//        view.endEditing(true)
//    }
//
    @objc private func didTapAddWeekButton() {
//        createStudyChapterService(completionHandler: {
//            self.navigationController?.popViewController(animated: true)
//        })
    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
//
//
}
//
//// MARK: - Create Study Chapter Service
//
//extension CreateWeekVC {
//
//    func createStudyChapterService(completionHandler: @escaping () -> Void) {
//        let token = KeychainWrapper.standard.string(forKey: "token") ?? ""
//        StudyService.shared.createStudyChapter(token: token, id: studyID, content: subjectTextField.text ?? "", date: dateTextField.text ?? "", place: locationTextField.text ?? "") { result in
//
//            switch result {
//                case .success(let res):
//                    let responseResult = res as! Response
//
//                    switch responseResult.status {
//                    case 200:
//                        completionHandler()
//
//                    case 400, 406, 411, 500, 420, 421, 422, 423:
//                        self.simpleAlert(title: responseResult.message, message: "")
//
//                        completionHandler()
//
//                    default:
//                        self.simpleAlert(title: "오류가 발생하였습니다", message: "")
//
//                        completionHandler()
//                    }
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
