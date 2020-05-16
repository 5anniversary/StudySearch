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
        view.addSubview(titleLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordVerificationField)
        view.addSubview(errorMessageLabel)
        view.addSubview(completeButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.right.equalTo(-20)
            make.height.equalTo(45)
        }
        
        passwordVerificationField.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.right.equalTo(passwordTextField)
            make.height.equalTo(passwordTextField)
            
        }

        errorMessageLabel.snp.makeConstraints{ make in
            make.left.equalTo(passwordVerificationField)
            make.top.equalTo(passwordVerificationField.snp.bottom).offset(10)
        }
        
        completeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(errorMessageLabel.snp.bottom).offset(30)
            make.width.equalTo(passwordTextField)
            make.height.equalTo(passwordTextField)
        }
    }
}
