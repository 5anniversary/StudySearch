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
    
    let passwordTitleLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .systemFont(ofSize: 13)
        $0.sizeToFit()
        $0.textColor = .black
    }
    
    let passwordVerificationTitleLabel = UILabel().then {
          $0.text = "비밀번호 확인"
          $0.font = .systemFont(ofSize: 13)
          $0.sizeToFit()
          $0.textColor = .black
      }

    let passwordTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.isSecureTextEntry = true
        $0.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    let conditionMessageLabel = UILabel().then {
        $0.text = "최소 6글자에서 최대 18글자"
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.sizeToFit()
    }
    
    let passwordVerificationField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.isSecureTextEntry = true
        $0.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    let errorMessageLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다"
        $0.textColor = .systemRed
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.sizeToFit()
        $0.isHidden = true
    }
    
    let completeButton = UIButton(type: .system).then {
        $0.setTitle("가입하기", for: .normal)
        $0.setTitleColor(.signatureColor, for: .normal)
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
        $0.isEnabled = false
        $0.alpha = 0.5
    }
    
      let backButton = UIButton(type: .system).then {
        $0.setTitle("이전", for: .normal)
        $0.setTitleColor(.signatureColor, for: .normal)
        $0.backgroundColor = .white
        $0.isEnabled = true
        $0.alpha = 1.0
        $0.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    
    
// MARK: - Variables and Properties
    
    var email: String?
    var password: String?
    
// MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "비밀번호 설정"
        addSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
        
    }
    
// MARK: - Helper
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func didTapCompleteButton() {
        password = passwordTextField.text!
        registerService(email: email!, password: password!)
    }
    
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - TextField Delegate

extension SignUpVC: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        // 비밀번호 입력 조건 확인
        if passwordTextField.text?.count ?? 0 >= 6 {
            conditionMessageLabel.isHidden = true
        } else {
            conditionMessageLabel.isHidden = false
        }
        
        // 두 비밀번호 일치 조건 확인
        if passwordTextField.text == passwordVerificationField.text {
            errorMessageLabel.isHidden = true
        } else {
            errorMessageLabel.isHidden = false
        }
        
        // 비밀번호 입력조건 충족에 따른 버튼 활성화
        if conditionMessageLabel.isHidden == true && errorMessageLabel.isHidden == true {
            completeButton.isEnabled = true
            completeButton.alpha = 1.0
        } else {
            completeButton.isEnabled = false
            completeButton.alpha = 0.5
        }
    }
    
}

// MARK: - Regitser Service

extension SignUpVC {
    
    func registerService(email: String, password: String) {
        UserService.shared.regitser(email: email, password: password) { result in
        
            switch result {
                case .success(let res):
                    let responseData = res as! Response
                    
                    switch responseData.status {
                    case 200:
                        let alert = UIAlertController(title: nil, message: "회원가입이 완료되었습니다", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "확인", style: .default) { (action) in
                            self.dismiss(animated: true, completion: nil)
                        }
                        alert.addAction(action)
                        
                        self.present(alert, animated: true)
                        
                    case 420:
                        let alert = UIAlertController(title: responseData.message, message: "", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "확인", style: .default) { (action) in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alert.addAction(action)
                        
                        self.present(alert, animated: true)
                        
                    case 400, 406, 411, 500, 421, 422,423:
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
    
}
