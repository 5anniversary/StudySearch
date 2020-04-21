//
//  AddUserInfoVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then

class AddUserInfoVC: UIViewController {
    
    // PickerView를 위한 Property
    let gender = ["성별", "남", "여"]
    
    // MARK: View
    
    // TODO: Gesture 추가하기
    let profileImageView = UIImageView().then {
        $0.backgroundColor = UIColor.gray
        $0.layer.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        $0.image = UIImage(systemName: "person.fill")
        $0.tintColor = UIColor.lightGray
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
    
    // TODO: 자기소개 Text View
    let selfIntroductionTextView = UITextView().then {
        $0.placeholder = "간단한 자기소개를 입력하세요*"
        $0.allowsEditingTextAttributes = true
        $0.setBorder(borderColor: .signatureColor, borderWidth: 1)
        $0.setRounded(radius: 10)
        $0.adjustsFontForContentSizeCategory = true
        
    }
    
    // TODO: nextButton
    let nextButton = UIButton().then {
        $0.setTitle("NEXT", for: .normal)
        $0.backgroundColor = .signatureColor
        $0.makeRounded(cornerRadius: 10)
//        $0.isEnabled = false
//        $0.alpha = 0.3
        $0.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        nicknameTextField.delegate = self
        ageTextField.delegate = self
        genderTextField.delegate = self
        
        //왜 then에서는 안되는가..
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView)))
        
        createGenderPickerView()
        addSubView()
    }
    
    // MARK: - Function
    
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
        guard let nickname = nicknameTextField.text, nickname != "",
            let age = ageTextField.text, age != "",
            let gender = genderTextField.text, gender != "",
            let selfIntro = selfIntroductionTextView.text, selfIntro != "" else {

            self.simpleAlert(title: "입력 오류", message: "필수 정보를 입력하세요.")
            return
        }
        
        let sb = self.storyboard
        let vc = sb?.instantiateViewController(identifier: "AddUserCategoryVC") as! AddUserCategoryVC
        navigationController?.pushViewController(vc, animated: true)
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

extension AddUserInfoVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nicknameTextField.resignFirstResponder()
        return false
    }
    
    // 입력에 따라 버튼 활성화, 비활성화 되도록...
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          
//        if nicknameTextField.text != "" && ageTextField.text != "" && genderTextField.text != "" {
//            nextButton.isEnabled = true
//            nextButton.alpha = 1.0
//        } else {
//            nextButton.isEnabled = false
//            nextButton.alpha = 0.3
//        }
//
//
//        guard let oldText = textField.text,
//        let stringRange = Range(range, in: oldText) else {
//            return false
//        }
//
//        let newText = oldText.replacingCharacters(in: stringRange, with: string)
//        if newText.isEmpty {
//            nextButton.isEnabled = false
//            nextButton.alpha = 0.3
//
//        } else {
//            if let nickname = nicknameTextField.text?.count, nickname > 0,
//                let age = ageTextField.text?.count, age > 0,
//                let gender = genderTextField.text?.count, gender > 0 {
//                nextButton.isEnabled = true
//                nextButton.alpha = 1.0
//            }
//        }
//
//        return true
//    }

}

extension AddUserInfoVC: UITextViewDelegate {
}
