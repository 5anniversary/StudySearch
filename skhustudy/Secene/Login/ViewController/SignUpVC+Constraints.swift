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
        view.addSubview(passwordTextField)
        view.addSubview(conditionMessageLabel)
        view.addSubview(passwordVerificationField)
        view.addSubview(errorMessageLabel)
        view.addSubview(completeButton)
        view.addSubview(backButton)
        view.addSubview(passwordTitleLabel)
        view.addSubview(passwordVerificationTitleLabel)
        
        passwordTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(105)
            make.left.equalTo(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(5)
            make.right.equalTo(-20)
            make.height.equalTo(45)
        }
        
        conditionMessageLabel.snp.makeConstraints{ make in
            make.left.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
        }
        
        passwordVerificationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionMessageLabel.snp.bottom).offset(25)
            make.left.equalTo(passwordTextField)
        }
        
        passwordVerificationField.snp.makeConstraints { make in
            make.left.equalTo(passwordTextField)
            make.top.equalTo(passwordVerificationTitleLabel.snp.bottom).offset(5)
            make.right.equalTo(passwordTextField)
            make.height.equalTo(passwordTextField)
            
        }
        
        errorMessageLabel.snp.makeConstraints{ make in
            make.left.equalTo(passwordVerificationField)
            make.top.equalTo(passwordVerificationField.snp.bottom).offset(10)
        }
        
        backButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        completeButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
