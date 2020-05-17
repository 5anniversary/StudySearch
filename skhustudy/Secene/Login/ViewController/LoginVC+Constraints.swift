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
        
        self.view.addSubview(titleLabel)
        
        self.view.addSubview(loginIDTextField)
        self.view.addSubview(loginPWTextField)
        
        self.view.addSubview(loginButton)
        
        self.view.addSubview(signUpLabel)
        self.view.addSubview(appleLoginButton)
        self.view.addSubview(facebookLoginButton)
        self.view.addSubview(normalSignUpButton)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        loginIDTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(titleLabel).offset(100)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(50)
        }
        
        loginPWTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(loginIDTextField.snp.bottom).offset(10)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints{ (make) in
            make.top.equalTo(loginPWTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
        
        
        signUpLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }
        
        appleLoginButton.snp.makeConstraints { (make) in
            make.top.equalTo(signUpLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        
        facebookLoginButton.snp.makeConstraints { (make) in
            make.top.equalTo(appleLoginButton).offset(50)
            make.left.equalTo(appleLoginButton)
            make.right.equalTo(appleLoginButton)
            make.height.equalTo(40)
        }
        // make.height.equalTo() 작동 오류를 대신할 코드
        facebookLoginButton.constraints.first(where: { (constraint) -> Bool in
            return constraint.firstAttribute == .height
        })?.constant = 40.0
        
        normalSignUpButton.snp.makeConstraints{ (make) in
            make.top.equalTo(facebookLoginButton).offset(50)
            make.left.equalTo(facebookLoginButton)
            make.right.equalTo(facebookLoginButton)
            make.height.equalTo(40)
        }
    }
    
}
