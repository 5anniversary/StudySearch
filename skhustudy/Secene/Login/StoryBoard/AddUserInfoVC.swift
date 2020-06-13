//
//  AddUserInfoVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Firebase
import FirebaseStorage
import SwiftKeychainWrapper
import Then

class AddUserInfoVC: UIViewController {
    
    //MARK: - UI components
    
    // MARK: View
    
    let profileImageView = UIImageView().then {
        $0.backgroundColor = UIColor.gray
        $0.layer.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        $0.image = UIImage(systemName: "person.fill")
        $0.tintColor = UIColor.lightGray
        $0.borderColor = UIColor.signatureColor
        $0.isUserInteractionEnabled = true
        $0.setRounded(radius: nil)
    }
    
    let addProfileImageButton = UIButton().then {
        let addButtonImage = UIImage(systemName: "plus")
        $0.layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        $0.setRounded(radius: nil)
        $0.setImage(addButtonImage, for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .signatureColor
    }
    
    let nicknameLabel = UILabel().then {
        $0.sizeToFit()
        $0.font = .systemFont(ofSize: 13)
        $0.sizeToFit()
        $0.textColor = .gray
        $0.text = "닉네임"
    }
    
    let nicknameTextField = UITextField().then {
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: UIColor.signatureColor, thickness: 1)
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    let ageLabel = UILabel().then {
        $0.sizeToFit()
        $0.font = .systemFont(ofSize: 13)
        $0.sizeToFit()
        $0.textColor = .gray
        $0.text = "나이"
    }
    let ageTextField = UITextField().then {
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.keyboardType = .numberPad
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    // 성별
    let genderLabel = UILabel().then {
        $0.sizeToFit()
        $0.font = .systemFont(ofSize: 13)
        $0.sizeToFit()
        $0.textColor = .gray
        $0.text = "성별"
    }
    
    let genderTextField = UITextField().then {
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    let locationLabel = UILabel().then {
        $0.sizeToFit()
        $0.font = .systemFont(ofSize: 13)
        $0.sizeToFit()
        $0.textColor = .gray
        $0.text = "활동 장소"
    }
    
    let locationTextField = UITextField().then {
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    // 자기소개 Text View
    let selfIntroLabel = UILabel().then {
        $0.sizeToFit()
        $0.font = .systemFont(ofSize: 13)
        $0.sizeToFit()
        $0.textColor = .gray
        $0.text = "자기소개"
    }
    
    // Text View bottom line을 위한 container 
    let textViewContainer = UIView().then {
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
    }
    
    lazy var selfIntroductionTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 17)
        $0.allowsEditingTextAttributes = true
        $0.adjustsFontForContentSizeCategory = true
        $0.isScrollEnabled = false
        $0.delegate = self
    }
    
    // TODO: confrimButton
    let confirmButton = UIBarButtonItem(title: "다음", style: .done, target: self, action: #selector(didTapConfirmButton))
    
    lazy var indicator = UIActivityIndicatorView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 80.0, height: 80.0)
    }
    
    //MARK: - Variables and Properties
    
    var isEditingMode = false
    
//    var isTextFieldFilled = false
//    var isTextViewFilled = false
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    // PickerView를 위한 Property
    let gender = ["성별", "남", "여"]
    let storage = Storage.storage()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEditingMode == true {
            confirmButton.title = "수정하기"
        } else {
            title = "정보 입력"
        }
        
        self.navigationItem.rightBarButtonItem = confirmButton
        
        // then에서 지정 시 작동 안됨
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContainerView)))
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView)))
        addProfileImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView)))
        
        addKeyboardNotification()
        createGenderPickerView()
        addSubView()
        print(#file, #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "정보 입력"
        print("viewdidAppear")
    }
    
    // MARK: - Helper
    
    @objc func didTapContainerView() {
        self.view.endEditing(true)
    }
    
    func createGenderPickerView() {
        let genderPickerView = UIPickerView()
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderTextField.inputView = genderPickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissGenderPickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        genderTextField.inputAccessoryView = toolbar
    }
    
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
        
        var rect = self.view.frame
        rect.size.height -= keyboardFrame.height
        if rect.contains(selfIntroductionTextView.frame.origin) {
            scrollView.scrollRectToVisible(selfIntroductionTextView.frame, animated: true)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func dismissGenderPickerView() {
        view.endEditing(true)
    }
    
    @objc func didTapProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    @objc func didTapConfirmButton() {
        print("didTapConfirm")
        guard var nickname = nicknameTextField.text, nickname != "",
            let age = ageTextField.text, age != "",
            var introduceMe = selfIntroductionTextView.text, introduceMe != "",
            var location = locationTextField.text, location != ""
            else {
                self.simpleAlert(title: "입력 오류", message: "필수 항목을 입력해주세요.")
            return
        }
        nickname = nickname.trimmingCharacters(in: .whitespaces)
        let isRightAge = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: age))
        var gender = genderTextField.text
        gender = gender?.trimmingCharacters(in: .whitespaces)
        introduceMe = introduceMe.trimmingCharacters(in: .whitespaces)
        location = location.trimmingCharacters(in: .whitespaces)
        
        
        if isRightAge == false {
            simpleAlert(title: "입력 오류", message: "알맞는 나이를 입력하세요")
        } else if gender?.count != 1 || ((gender == "남" || gender == "여") != true){
            simpleAlert(title: "입력 오류", message: "성별을 입력하세요")
        } else {
            
            let uid = KeychainWrapper.standard.string(forKey: "userID")!
            let storageRef = storage.reference().child("images/\(uid).jpeg")
            if profileImageView.image != nil {
                let uploadData = profileImageView.image?.jpegData(compressionQuality: 0.1)
                if let data = uploadData {
                    storageRef.putData(data, metadata: nil) { (data, error) in
                        //                        guard let metadata = data else { return }
                        if error != nil {
                            print("Firebase 이미지 저장 에러")
                            //                            print(error?.localizedDescription)
                            return
                        }
                        
                        storageRef.downloadURL { (url, error) in
                            if error != nil {
                                print("Firebase download url 에러")
                                return
                            }
                            
                            guard let downloadURL = url else {
                                print("downloadURL nil")
                                return
                            }
                            
                            if self.isEditingMode == true {
                                self.addUserInfoService(
                                    age: Int(String(age))!,
                                    gender: (gender == "남") ? 0 : 1,
                                    nickname: nickname
                                    , introduceMe: introduceMe,
                                      location: location,
                                      imageURL: downloadURL.absoluteString
                                )
                                
                            } else {
                                let sb = self.storyboard
                                let vc = sb?.instantiateViewController(identifier: "AddUserCategoryVC") as! AddUserCategoryVC
                                vc.nickname = nickname
                                vc.age = Int(String(age))!
                                vc.gender = (gender == "남") ? 0 : 1
                                vc.location = location
                                vc.introduceMe = introduceMe
                                vc.imageURL = downloadURL.absoluteString
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            
                        }
                    }
                }
                
            } else {
                // 사용자가 지정한 이미지가 없는 경우
                if isEditingMode == true {
                    //                    addUserInfoService()
                    print("편집 모드 입니다.")
                    
                } else {
                    let sb = self.storyboard
                    let vc = sb?.instantiateViewController(identifier: "AddUserCategoryVC") as! AddUserCategoryVC
                    vc.nickname = nickname
                    vc.age = Int(String(age))!
                    vc.gender = (gender == "남") ? 0 : 1
                    vc.location = location
                    vc.introduceMe = introduceMe
                    vc.imageURL = ""
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                
            }
        }
        
    }
    
    
    
}


// MARK: - 입력 텍스트 값 변화 감지 Delegate

extension AddUserInfoVC: UITextViewDelegate {
    // 자기소개란의 PlaceHolder 지정
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //        if (selfIntroductionTextView.text == "") {
    //            selfIntroductionTextView.text = "간단한 자기소개를 입력하세요*"
    //            selfIntroductionTextView.textColor = UIColor.lightGray
    //        }
    //        selfIntroductionTextView.resignFirstResponder()
    //    }
    //
    //    func textViewDidBeginEditing(_ textView: UITextView){
    //        if (selfIntroductionTextView.text == "간단한 자기소개를 입력하세요*"){
    //            selfIntroductionTextView.text = ""
    //            selfIntroductionTextView.textColor = UIColor.black
    //        }
    //        selfIntroductionTextView.becomeFirstResponder()
    //    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }

}

//extension AddUserInfoVC : UITextFieldDelegate {
//
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        // 입력된 빈칸 감지하기
//        var nameStr = nicknameTextField.text
//        var ageStr = ageTextField.text
//        var genderStr = genderTextField.text
//        var locationStr = locationTextField.text
//
//        nameStr = nameStr?.replacingOccurrences(of: " ", with: "")
//        ageStr = ageStr?.replacingOccurrences(of: " ", with: "")
//        genderStr = genderStr?.replacingOccurrences(of: " ", with: "")
//        locationStr = locationStr?.replacingOccurrences(of: " ", with: "")
//
//        if nameStr?.count != 0 &&
//            ageStr?.count != 0 &&
//            genderStr?.count != 0 &&
//            locationStr?.count != 0 {
//
//            isTextFieldFilled = true
//        } else {
//            isTextFieldFilled = false
//        }
//
//        // TextField와 TextView의 입력조건 충족 동시 확인
//        if isTextFieldFilled == true && isTextViewFilled == true {
//            confirmButton.isEnabled = true
//        } else {
//            confirmButton.isEnabled = false
//        }
//    }
//
//}


extension AddUserInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        profileImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


extension AddUserInfoVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if gender[row] == "성별" {
            return
        }
        genderTextField.text = gender[row]
    }
    
}

// MARK: - Logout Serivce

extension AddUserInfoVC {
    func logoutService() {
        let token = KeychainWrapper.standard.string(forKey: "token") ?? ""
        UserService.shared.logout(token: token) { result in
            switch result {
            case .success(let res):
                let responseData = res as! Response
                
                switch responseData.status {
                case 200:
                    let presentVC = self.presentingViewController
                    self.dismiss(animated: true, completion: {
                        presentVC?.simpleAlert(title: "로그아웃 되었습니다", message: "")
                    })
                    
                case 400, 406, 411, 500, 420, 421, 422, 423:
                    // 411 - 토큰이 효력을 잃은 경우
                    self.simpleAlert(title: responseData.message, message: "")
                    
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
    
    func addUserInfoService(age: Int, gender: Int, nickname: String, introduceMe: String, location: String, imageURL: String) {
        guard let token = KeychainWrapper.standard.string(forKey: "token") else { return }
        UserService.shared.modifyUserInfo(token: token, age: age, gender: gender, nickname: nickname, introduceMe: introduceMe, location: location, pickURL: imageURL, category: []) { (result) in
            switch result {
            case .success(let result):
                let user = result as! User
                let userData = user.data
                
                let ref = Firestore.firestore().collection("users").document("\(userData.userID)")
                ref.updateData([
                    "uid": userData.userID,
                    "imageURL": userData.image,
                    "nickname": userData.nickName
                ]) { (error) in
                    if error == nil {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        print("수정 firebase 저장 에러")
                    }
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

