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
        self.view.addSubview(emailTextField)
        self.view.addSubview(pwTextField)
        self.view.addSubview(nicknameTextField)
        self.view.addSubview(completeButton)
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.width.equalTo(emailTextField)
            make.height.equalTo(emailTextField)
            
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(pwTextField.snp.bottom).offset(30)
            make.width.equalTo(emailTextField)
            make.height.equalTo(emailTextField)
            
        }
        
        completeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.width.equalTo(emailTextField)
            make.height.equalTo(emailTextField)
        }
    }
}
