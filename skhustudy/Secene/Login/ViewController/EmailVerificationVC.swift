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
    
    let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 25)
        $0.sizeToFit()
        $0.text = "이메일 인증"
    }
    
    let emailTextField = UITextField().then {
        $0.placeholder = "이메일"
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
    }
    
    let sendButton = UIButton(type: .system).then {
        $0.setTitle("전송", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .signatureColor
        $0.makeRounded(cornerRadius: 10)
        $0.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    let verificationNumberTextField = UITextField().then {
        $0.placeholder = "인증번호"
        $0.textAlignment = .left
        $0.keyboardType = .numberPad
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
    }
    
    let verificationButton = UIButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .signatureColor
        $0.makeRounded(cornerRadius: 10)
        $0.addTarget(self, action: #selector(didTapVerificationButton), for: .touchUpInside)
        $0.isEnabled = false
        $0.alpha = 0.0
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func didTapSendButton(){
        // 인증번호 생성
        let randomNumber = arc4random_uniform(899999) + 100000
        let verificationNumber = String(randomNumber)
        print(verificationNumber)
        
        // TODO: 인증번호 이메일로 전송 성공하면
            // 인증번호 로컬 저장(덮어씌우기)
        UserDefaults.standard.set(verificationNumber, forKey: "emailVerificationID")
        verificationButton.isEnabled = true
        verificationButton.alpha = 1.0
        
        
    }
    
    @objc func didTapVerificationButton(){
        // TODO: 인증번호 로컬 저장했던 번호와 비교
        if let verificationNumber = UserDefaults.standard.string(forKey: "emailVerificationID"),
            let userInput = verificationNumberTextField.text, userInput != "" {
            // 인증번호가 맞으면 다음 화면으로 이동 + 인증번호 지우기
            if verificationNumber == userInput {
                print("인증 성공")
                
                UserDefaults.standard.removeObject(forKey: "emailVerificationID")
                let sb = UIStoryboard(name: "SignUp", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                print("인증 실패")
                self.simpleAlert(title: "인증 실패", message: "인증번호를 다시 확인해주세요.")
                
            }
        }
    }
    
}
