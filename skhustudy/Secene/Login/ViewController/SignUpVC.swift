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
    let passwordTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "비밀번호"
    }
    
    let passwordVerificationField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "비밀번호 확인"
        $0.isSecureTextEntry = true
    }
    
    let nicknameTextField = UITextField().then {
        $0.borderStyle = .roundedRect
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
    
    @objc func didTapCompleteButton() {
        // TODO: 입력 필드 모두 입력하고, 입력 형식을 따라야 버튼 활성화 되게
        guard let email = passwordTextField.text,
            let pw = passwordVerificationField.text else { return }
        
        // TODO: 회원가입 로직 email 인증 방식으로 바꿔야하면 할 것.
        Auth.auth().createUser(withEmail: email, password: pw) { (result, error) in
            guard let user = result?.user else { return }
            
            if error == nil {
                // TODO: Database 쓰기

            } else {
                print("Create user error \(error!.localizedDescription)")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

