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
        
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalToSuperview().offset(105)
            make.right.equalTo(-20)
            make.height.equalTo(45)
        }
        
        conditionMessageLabel.snp.makeConstraints{ make in
            make.left.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
        }
        
        passwordVerificationField.snp.makeConstraints { make in
            make.left.equalTo(passwordTextField)
            make.top.equalTo(conditionMessageLabel.snp.bottom).offset(30)
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
