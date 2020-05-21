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
    
    let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력하세요*"
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: UIColor.signatureColor, thickness: 1)
    }
    
    let ageTextField = UITextField().then {
        $0.placeholder = "나이를 입력하세요*"
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.keyboardType = .numberPad
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
    }
    // 성별
    let genderTextField = UITextField().then {
        $0.placeholder = "성별을 입력하세요*"
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
    }
    
    let locationTextField = UITextField().then {
        $0.placeholder = "거주 지역*"
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
    }
    
    // 자기소개 Text View
    let selfIntroductionTextView = UITextView().then {
        $0.placeholder = "간단한 자기소개를 입력하세요*"
        $0.font = .systemFont(ofSize: 15)
        $0.allowsEditingTextAttributes = true
        $0.setBorder(borderColor: .signatureColor, borderWidth: 1)
        $0.setRounded(radius: 10)
        $0.adjustsFontForContentSizeCategory = true
        $0.isScrollEnabled = false
        
    }
    
    // TODO: nextButton
    let nextButton = UIButton().then {
        $0.setTitle("NEXT", for: .normal)
        $0.backgroundColor = .signatureColor
        $0.makeRounded(cornerRadius: 10)
        $0.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    lazy var indicator = UIActivityIndicatorView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 80.0, height: 80.0)
    }
    
    //MARK: - Variables and Properties
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    // PickerView를 위한 Property
    let gender = ["성별", "남", "여"]
    let storage = Storage.storage()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContainerView)))
        
        //왜 then에서는 안되는가..
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView)))
        
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
    
    @objc func didTapNextButton() {
        guard let nickname = nicknameTextField.text, !nickname.isEmpty,
            let age = ageTextField.text, !age.isEmpty,
            let gender = genderTextField.text, !gender.isEmpty,
            let introduceMe = selfIntroductionTextView.text, !introduceMe.isEmpty,
            let location = locationTextField.text, !location.isEmpty else {
                self.simpleAlert(title: "입력 오류", message: "필수 정보를 입력하세요.")
                return
        }
        indicator.startAnimating()
        // TODO: image firebase에 저장 후 url 생성
        let storageRef = storage.reference().child("images/profile.png")
        let uploadData = profileImageView.image!.pngData()
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
                    vc.nickname = nickname
                    vc.age = Int(age)!
                    vc.gender = (gender == "남") ? 0 : 1
                    vc.location = location
                    vc.introduceMe = introduceMe
                    vc.imageURL = downloadURL.absoluteString
                    self.indicator.startAnimating()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
            }
        }
        
    }
    
}


// MARK: - Extension

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
