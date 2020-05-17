//
//  SignUpVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/19.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth
import SnapKit
import Then

class SignUpVC: UIViewController {
    
// MARK: - UI components
    
    // 회원가입 화면
    let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 25)
        $0.sizeToFit()
        $0.text = "비밀번호 설정"
    }
    
    let passwordTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
    }
    let conditionMessageLabel = UILabel().then {
        $0.text = "최소 6글자에서 최대 18글자"
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.sizeToFit()
    }
    
    let passwordVerificationField = UITextField().then {
        $0.borderStyle = .none
        $0.placeholder = "비밀번호 확인"
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.isSecureTextEntry = true
    }
    let errorMessageLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다"
        $0.textColor = .systemRed
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.sizeToFit()
        $0.isHidden = true
    }
    
    let completeButton = UIButton(type: .system).then {
        $0.setTitle("가입 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.signatureColor
        $0.makeRounded(cornerRadius: 5)
        $0.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
    }
    
// MARK: - Variables and Properties
    
    var email: String?
    var password: String?
    
// MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        
        passwordTextField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordVerificationField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
// MARK: - Helper
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func didTapCompleteButton() {
        // 비밀번호 입력 조건이 충족되었는지 확인
        if conditionMessageLabel.isHidden == true && errorMessageLabel.isHidden == true {
            password = passwordTextField.text!
            
            registerService(email: email!, password: password!)
        }
    }
    
}

// MARK: - TextFieldDelegate

extension SignUpVC: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if passwordTextField.text == passwordVerificationField.text {
            errorMessageLabel.isHidden = true
        } else {
            errorMessageLabel.isHidden = false
        }
        
        if passwordTextField.text?.count ?? 0 >= 6 {
            conditionMessageLabel.isHidden = true
        } else {
            conditionMessageLabel.isHidden = false
        }
    }
    
}

// MARK: - regitser service

extension SignUpVC {
    
    func registerService(email: String, password: String) {
        UserService.shared.regitser(email: email, password: password) { result in
        
            switch result {
                case .success(_):
                    let alert = UIAlertController(title: nil, message: "회원가입이 완료되었습니다", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "확인", style: .default) { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(action)
                    
                    self.present(alert, animated: true)
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
