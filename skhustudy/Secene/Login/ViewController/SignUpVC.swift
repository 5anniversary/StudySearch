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
        $0.text = "회원가입"
    }
    
    let passwordTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
    }
    
    let passwordVerificationField = UITextField().then {
        $0.borderStyle = .none
        $0.placeholder = "비밀번호 확인"
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.isSecureTextEntry = true
    }
    
    let nicknameTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.placeholder = "닉네임"
    }
    
    let completeButton = UIButton(type: .system).then {
        $0.setTitle("가입 완료", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = UIColor.signatureColor
        $0.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        
    }
    
    // MARK: - Helper
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func didTapCompleteButton() {
        // TODO: 입력 필드 모두 입력하고, 입력 형식을 따라야 버튼 활성화 되게
        guard let email = passwordTextField.text,
            let pw = passwordVerificationField.text else { return }
        
        // TODO: 회원가입 로직
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

