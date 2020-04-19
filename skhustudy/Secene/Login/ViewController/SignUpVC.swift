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
    
    //MARK: - Firebase
    
    // firebase 데이터베이스를 사용하기 위한 인스턴스 생성
    var ref: DatabaseReference!
    
    // MARK: - UI components
    
    // 회원가입 화면
    let emailTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "Email"
    }
    
    let pwTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "Password"
        $0.isSecureTextEntry = true
    }
    
    let nicknameTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "Nickname"
    }
    
    let completeButton = UIButton(type: .system).then {
        $0.setTitle("가입 완료", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .systemOrange
        $0.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        
    }
    
    // MARK: - Helper
    
    @objc func didTapCompleteButton() {
        
        // TODO: 회원가입 로직
//        Auth.auth().createUser(withEmail: emailTextField.text!, password: pwTextField.text!) { (result, error) in
//            guard let user = result?.user else { return }
//
//
//            if error == nil {
//                // TODO: Database 쓰기
//
//            } else {
//                print("Create user error \(error!.localizedDescription)")
//            }
//        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

