//
//  AddUserInfoVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import FirebaseStorage
import SwiftKeychainWrapper
import Then

class AddUserInfoVC: UIViewController {
    
    //MARK: - UI components
    
    // MARK: View
    let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.text = "사용자 정보를 입력하세요."
    }
    
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
    
    let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력하세요*"
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: UIColor.signatureColor, thickness: 1)
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let ageTextField = UITextField().then {
        $0.placeholder = "나이를 입력하세요*"
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.keyboardType = .numberPad
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    // 성별
    let genderTextField = UITextField().then {
        $0.placeholder = "성별을 입력하세요*"
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let locationTextField = UITextField().then {
        $0.placeholder = "거주 지역*"
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    // 자기소개 Text View
    let selfIntroductionTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 15)
        $0.allowsEditingTextAttributes = true
        $0.setBorder(borderColor: .signatureColor, borderWidth: 1)
        $0.setRounded(radius: 10)
        $0.adjustsFontForContentSizeCategory = true
        $0.isScrollEnabled = false
    }
    
    // TODO: confrimButton
    let confirmButton = UIButton().then {
        $0.setTitle("NEXT", for: .normal)
        $0.backgroundColor = .signatureColor
        $0.makeRounded(cornerRadius: 10)
        $0.isEnabled = false
        $0.alpha = 0.5
        $0.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }
    
    lazy var indicator = UIActivityIndicatorView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 80.0, height: 80.0)
    }
    
    //MARK: - Variables and Properties
    
    var isEditingMode = false
    
    var isTextFieldFilled = false
    var isTextViewFilled = false
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    // PickerView를 위한 Property
    let gender = ["성별", "남", "여"]
    let storage = Storage.storage()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add placeholder function for textview
        selfIntroductionTextView.delegate = self
        if (selfIntroductionTextView.text == "") {
            textViewDidEndEditing(selfIntroductionTextView)
        }
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // then에서 지정 시 작동 안됨
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContainerView)))
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView)))
        addProfileImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView)))
        
        addKeyboardNotification()
        createGenderPickerView()
        addSubView()
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
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
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
        
        var nickname = nicknameTextField.text
        nickname = nickname?.trimmingCharacters(in: .whitespaces)
        
        let age = ageTextField.text
        let isRightAge = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: age!))
        
        var gender = genderTextField.text
        gender = gender?.trimmingCharacters(in: .whitespaces)
        
        var introduceMe = selfIntroductionTextView.text
        introduceMe = introduceMe?.trimmingCharacters(in: .whitespaces)
        
        var location = locationTextField.text
        location = location?.trimmingCharacters(in: .whitespaces)
        
        if isRightAge == false {
            simpleAlert(title: "입력 오류", message: "알맞는 나이를 입력하세요")
        } else if gender?.count != 1 || ((gender == "남" || gender == "여") != true){
                simpleAlert(title: "입력 오류", message: "성별을 입력하세요")
        } else {
            indicator.startAnimating()
            let uid = KeychainWrapper.standard.string(forKey: "userID")!
        
            let storageRef = storage.reference().child("images/\(uid).jpeg")
            if profileImageView.image != nil {
                let uploadData = profileImageView.image?.jpegData(compressionQuality: 0.1)
                if let data = uploadData {
                    storageRef.putData(data, metadata: nil) { (data, error) in
                        guard let metadata = data else { return }
                        
                        if error != nil {
                            return
                        }
                        
                        storageRef.downloadURL { (url, error) in
                            if error != nil {
                                return
                            }
                            
                            guard let downloadURL = url else {
                                return
                            }
                            
                            let sb = self.storyboard
                            let vc = sb?.instantiateViewController(identifier: "AddUserCategoryVC") as! AddUserCategoryVC
                            vc.nickname = nickname!
                            vc.age = Int(String(age!))!
                            vc.gender = (gender == "남") ? 0 : 1
                            vc.location = location!
                            vc.introduceMe = introduceMe!
                            vc.imageURL = downloadURL.absoluteString
                            self.indicator.startAnimating()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            } else {
                // 사용자가 지정한 이미지가 없는 경우
                let sb = self.storyboard
                let vc = sb?.instantiateViewController(identifier: "AddUserCategoryVC") as! AddUserCategoryVC
                vc.nickname = nickname!
                vc.age = Int(String(age!))!
                vc.gender = (gender == "남") ? 0 : 1
                vc.location = location!
                vc.introduceMe = introduceMe!
                vc.imageURL = ""
                self.indicator.startAnimating()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
   
    }
    
}


// MARK: - 입력 텍스트 값 변화 감지 Delegate

extension AddUserInfoVC: UITextViewDelegate {
    // 자기소개란의 PlaceHolder 지정
    func textViewDidEndEditing(_ textView: UITextView) {
        if (selfIntroductionTextView.text == "") {
            selfIntroductionTextView.text = "간단한 자기소개를 입력하세요*"
            selfIntroductionTextView.textColor = UIColor.lightGray
        }
        selfIntroductionTextView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView){
        if (selfIntroductionTextView.text == "간단한 자기소개를 입력하세요*"){
            selfIntroductionTextView.text = ""
            selfIntroductionTextView.textColor = UIColor.black
        }
        selfIntroductionTextView.becomeFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var str = selfIntroductionTextView.text.replacingOccurrences(of: " ", with: "")
        str = str.replacingOccurrences(of: "\n", with: "")
        
        if str.count != 0 {
            isTextViewFilled = true
        } else {
            isTextViewFilled = false
        }
        
        // TextField와 TextView의 입력조건 충족 동시 확인
        if isTextFieldFilled == true && isTextViewFilled == true {
            confirmButton.isEnabled = true
            confirmButton.alpha = 1.0
        } else {
            confirmButton.isEnabled = false
            confirmButton.alpha = 0.5
        }
    }
    
}

extension AddUserInfoVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        // 입력된 빈칸 감지하기
        var nameStr = nicknameTextField.text
        var ageStr = ageTextField.text
        var genderStr = genderTextField.text
        var locationStr = locationTextField.text
        
        nameStr = nameStr?.replacingOccurrences(of: " ", with: "")
        ageStr = ageStr?.replacingOccurrences(of: " ", with: "")
        genderStr = genderStr?.replacingOccurrences(of: " ", with: "")
        locationStr = locationStr?.replacingOccurrences(of: " ", with: "")
        
        if nameStr?.count != 0 &&
            ageStr?.count != 0 &&
            genderStr?.count != 0 &&
            locationStr?.count != 0 {
            
            isTextFieldFilled = true
        } else {
            isTextFieldFilled = false
        }
        
        // TextField와 TextView의 입력조건 충족 동시 확인
        if isTextFieldFilled == true && isTextViewFilled == true {
            confirmButton.isEnabled = true
            confirmButton.alpha = 1.0
        } else {
            confirmButton.isEnabled = false
            confirmButton.alpha = 0.5
        }
    }

}


extension AddUserInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        profileImageView.image = image
        
        // TODO: Update Database
        
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
