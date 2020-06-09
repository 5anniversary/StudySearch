//
//  LoginVC+Constraints.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/17.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

extension LoginVC {
    
    func addSubView(){
        
        self.view.addSubview(titleLogoImageView)
        
        self.view.addSubview(idLabel)
        self.view.addSubview(loginIDTextField)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(loginPWTextField)
        
        self.view.addSubview(loginButton)
        
        self.view.addSubview(signUpLabel)
        self.view.addSubview(leftLineView)
        self.view.addSubview(rightLineView)
        
        self.view.addSubview(normalSignUpButton)
        
        titleLogoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(90)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLogoImageView.snp.bottom).offset(50)
            make.left.equalTo(30)
        }
        
        loginIDTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(idLabel).offset(18)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        }
        
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(loginIDTextField.snp.bottom).offset(20)
            make.left.equalTo(loginIDTextField)
        }
        
        loginPWTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(passwordLabel).offset(18)
            make.left.equalTo(loginIDTextField.snp.left)
            make.right.equalTo(loginIDTextField.snp.right)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints{ (make) in
            make.top.equalTo(loginPWTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(65)
        }
        
        
        signUpLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        leftLineView.snp.makeConstraints{ (make) in
            make.right.equalTo(signUpLabel.snp.left).offset(-30)
            make.height.equalTo(1)
            make.width.equalTo(90)
            make.centerY.equalTo(signUpLabel)
        }
        rightLineView.snp.makeConstraints{ (make) in
            make.left.equalTo(signUpLabel.snp.right).offset(30)
            make.height.equalTo(leftLineView.snp.height)
            make.width.equalTo(leftLineView.snp.width)
            make.centerY.equalTo(signUpLabel)
        }
        
        normalSignUpButton.snp.makeConstraints{ (make) in
            make.top.equalTo(signUpLabel.snp.bottom).offset(30)
            make.left.equalTo(loginButton)
            make.right.equalTo(loginButton)
            make.height.equalTo(40)
        }
    }
    
}
