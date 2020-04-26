//
//  AddUserInfoVC+Constraints.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SnapKit

extension AddUserInfoVC {
    func addSubView() {
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(ageTextField)
        view.addSubview(genderTextField)
        view.addSubview(selfIntroductionTextView)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(18)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
        }
        
        ageTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.width.equalTo(nicknameTextField)
            make.height.equalTo(nicknameTextField)
        }
        
        genderTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ageTextField.snp.bottom).offset(30)
            make.width.equalTo(nicknameTextField)
            make.height.equalTo(nicknameTextField)
        }
        
        selfIntroductionTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(genderTextField.snp.bottom).offset(30)
            make.width.equalTo(nicknameTextField)
            make.height.equalTo(nicknameTextField).multipliedBy(3)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(selfIntroductionTextView.snp.bottom).offset(50)
            make.width.equalTo(nicknameTextField)
            make.height.equalTo(nicknameTextField).multipliedBy(2)
        }
        
        
    }
}
