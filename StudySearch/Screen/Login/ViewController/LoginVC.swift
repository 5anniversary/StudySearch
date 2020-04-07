//
//  LoginVC.swift
//  StudySearch
//
//  Created by Junhyeon on 2020/04/07.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import AuthenticationServices
import Then
import SnapKit

class LoginVC: UIViewController {
    
    // MARK: - UI components
    
    let appleLoginButton = ASAuthorizationAppleIDButton().then{
        
        $0.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
    }
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
    }
    
    
    // MARK: - Helper
    
    @objc func appleLogin(){
        debugPrint("123")
    }
    
    func addSubView(){
        
        self.view.addSubview(appleLoginButton)
        appleLoginButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview().offset(100)
            make.height.equalTo(40)
        }

    }
    
}

// MARK: - extension에 따라 적당한 명칭 작성
