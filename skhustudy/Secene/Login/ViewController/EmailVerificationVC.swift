//
//  EmailVerificationVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/05/11.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then

class EmailVerificationVC: UIViewController {
    
    let emailTextField = UITextField().then {
        $0.placeholder = "이메일"
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.addTarget(self, action: #selector(EmailVerificationVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    let conditionMessageLabel = UILabel().then {
        $0.text = "이메일 형식이 아닙니다."
        $0.textColor = .red
        $0.isHidden = true
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.sizeToFit()
    }
    
    let sendButton = UIButton(type: .system).then {
        $0.setTitle("인증하기", for: .normal)
        $0.setTitleColor(.signatureColor, for: .normal)
        $0.backgroundColor = .signatureColor
        $0.setTitleColor(.white, for: .normal)
        $0.makeRounded(cornerRadius: 10)
        $0.isEnabled = true
        $0.alpha = 0.5
        $0.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        
    }
    
    let verificationNumberTextField = UITextField().then {
        $0.placeholder = "인증번호"
        $0.textAlignment = .left
        $0.keyboardType = .numberPad
        $0.borderStyle = .none
        $0.alpha = 0.0
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
    }
    
    let verificationButton = UIButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .signatureColor
        $0.setTitleColor(.white, for: .normal)
        $0.makeRounded(cornerRadius: 10)
        $0.addTarget(self, action: #selector(didTapVerificationButton), for: .touchUpInside)
        $0.isEnabled = false
        $0.alpha = 0.0
    }
    
    let errorMessageLabel = UILabel().then {
        $0.text = "인증번호가 일치하지 않습니다."
        $0.textColor = .red
        $0.isHidden = true
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.sizeToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "이메일 인증"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
        
        addSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func didTapSendButton(){
        // 인증번호 생성
        let randomNumber = arc4random_uniform(899999) + 100000
        let verificationNumber = String(randomNumber)
        print(verificationNumber)
        sendEmail(to: emailTextField.text!, verificationNumber: verificationNumber)
        
    }
    
    @objc private func didTapVerificationButton(){
        // 인증번호 로컬 저장했던 번호와 비교
        if let verificationNumber = UserDefaults.standard.string(forKey: "emailVerificationID"),
            let userInput = verificationNumberTextField.text, userInput != "" {
            // 인증번호가 맞으면 다음 화면으로 이동 + 인증번호 지우기
            if verificationNumber == userInput {
                
                UserDefaults.standard.removeObject(forKey: "emailVerificationID")
                let sb = UIStoryboard(name: "SignUp", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
                vc.email = emailTextField.text!
                verificationNumberTextField.text = ""
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                errorMessageLabel.isHidden = false
            }
        }
    }
    
}

extension EmailVerificationVC {
    func sendEmail(to email: String, verificationNumber: String) {
        UserService.shared.sendEmail(
            email,
            "인증번호를 입력해주세요. \n인증번호: \(verificationNumber)") { result in
                
                switch result {
                case .success(_):
                    UserDefaults.standard.set(verificationNumber, forKey: "emailVerificationID")
                    self.conditionMessageLabel.isHidden = false
                    self.conditionMessageLabel.text = "해당 이메일에서 인증번호를 확인해 주시기 바랍니다."
                    self.conditionMessageLabel.textColor = .systemBlue
                    self.verificationAnimate()
                    
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

extension EmailVerificationVC {
    private func verificationAnimate(){
        UIView.animate(
            withDuration: 1.2,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1,
            options: [.curveEaseIn],
            animations: {
                self.verificationNumberTextField.alpha = 1.0
                self.verificationNumberTextField.transform = CGAffineTransform(translationX: 0, y: 5)
                self.verificationButton.alpha = 1.0
                self.verificationButton.isEnabled = true
                self.verificationButton.transform = CGAffineTransform(translationX: 0, y: 5)
        })
    }
}

extension EmailVerificationVC: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let email = emailTextField.text {
            if email.validateEmail() {
                conditionMessageLabel.isHidden = true
                sendButton.isEnabled = true
                sendButton.alpha = 1.0
            } else {
                conditionMessageLabel.isHidden = false
                sendButton.isEnabled = false
                sendButton.alpha = 0.5
            }
        }
        
        
        
    }
}

