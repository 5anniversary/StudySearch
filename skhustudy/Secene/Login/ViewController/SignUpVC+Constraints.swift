//
//  SignUpVC+Constraints.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/19.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

extension SignUpVC {
    func addSubView() {
        self.view.addSubview(passwordTextField)
        self.view.addSubview(passwordVerificationField)
        self.view.addSubview(nicknameTextField)
        self.view.addSubview(completeButton)
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
        }
        
        passwordVerificationField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.width.equalTo(passwordTextField)
            make.height.equalTo(passwordTextField)
            
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordVerificationField.snp.bottom).offset(30)
            make.width.equalTo(passwordTextField)
            make.height.equalTo(passwordTextField)
            
        }
        
        completeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.width.equalTo(passwordTextField)
            make.height.equalTo(passwordTextField)
        }
    }
}
