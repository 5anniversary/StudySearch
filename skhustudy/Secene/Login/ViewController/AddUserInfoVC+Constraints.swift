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
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(profileImageView)
        containerView.addSubview(nicknameTextField)
        containerView.addSubview(ageTextField)
        containerView.addSubview(genderTextField)
        containerView.addSubview(locationTextField)
        containerView.addSubview(selfIntroductionTextView)
        containerView.addSubview(nextButton)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(18)
            make.width.equalToSuperview().offset(0.7)
            make.height.equalTo(40)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
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
        
        locationTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(genderTextField.snp.bottom).offset(30)
            make.width.equalTo(nicknameTextField)
            make.height.equalTo(nicknameTextField)
        }
        
        selfIntroductionTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationTextField.snp.bottom).offset(30)
            make.width.equalTo(nicknameTextField)
            make.bottom.equalTo(nextButton.snp.top).offset(-30)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(nicknameTextField)
            make.height.equalTo(nicknameTextField).multipliedBy(1.5)
            make.bottom.equalTo(containerView.snp.bottom).offset(-80)
        }
        
        
    }
}
