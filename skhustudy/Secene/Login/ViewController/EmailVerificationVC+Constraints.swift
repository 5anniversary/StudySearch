//
//  EmailVerificationVC+Constraints.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/05/11.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SnapKit

extension EmailVerificationVC {
    func addSubView() {
        view.addSubview(emailTextField)
        view.addSubview(conditionMessageLabel)
        view.addSubview(sendButton)
        view.addSubview(verificationNumberTextField)
        view.addSubview(errorMessageLabel)
        view.addSubview(verificationButton)
  
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(105)
            make.left.equalTo(20)
            make.height.equalTo(45)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField)
            make.left.equalTo(emailTextField.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(emailTextField)
            make.width.equalTo(70)
        }
        
        conditionMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(6)
            make.left.equalTo(emailTextField)
        }
        
        verificationNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(conditionMessageLabel.snp.bottom).offset(20)
            make.left.equalTo(emailTextField)
            make.height.equalTo(emailTextField)
            
        }
        
        errorMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(verificationNumberTextField.snp.bottom).offset(10)
            make.left.equalTo(emailTextField)
        }
        
        verificationButton.snp.makeConstraints { make in
            make.top.equalTo(verificationNumberTextField)
            make.left.equalTo(verificationNumberTextField.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(emailTextField)
            make.width.equalTo(70)
        }
        
    }
}
