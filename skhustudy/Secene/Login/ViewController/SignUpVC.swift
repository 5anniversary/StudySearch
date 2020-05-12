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
    
    let passwordVerificationField = UITextField().then {
        $0.borderStyle = .none
        $0.placeholder = "비밀번호 확인"
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.isSecureTextEntry = true
    }

    let completeButton = UIButton(type: .system).then {
        $0.setTitle("가입 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.signatureColor
        $0.makeRounded(cornerRadius: 5)
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
    
    var email: String = ""
    @objc func didTapCompleteButton() {
        // TODO: 비밀번호와 비밀번호 확인 입력이 같은지 확인
        
        // TODO: 회원가입 로직
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

