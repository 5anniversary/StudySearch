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
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(sendButton)
        view.addSubview(verificationNumberTextField)
        view.addSubview(verificationButton)
        view.addSubview(cancelButton)
        
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().offset(-17)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(titleLabel)
            make.height.equalTo(45)
            
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField)
            make.left.equalTo(emailTextField.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(emailTextField)
            make.width.equalTo(70)
        }
        
        verificationNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.equalTo(titleLabel)
            make.height.equalTo(emailTextField)
            
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
