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
        containerView.addSubview(addProfileImageButton)
        
        containerView.addSubview(nicknameTextField)
        containerView.addSubview(ageTextField)
        containerView.addSubview(genderTextField)
        containerView.addSubview(locationTextField)
        containerView.addSubview(selfIntroductionTextView)
        
        containerView.addSubview(nextButton)
        
        containerView.addSubview(indicator)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.size.height)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(scrollView.snp.height)
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { make in
            if isEditingMode == false {
                make.top.equalToSuperview().offset(20)
                make.leading.equalToSuperview().offset(18)
                make.width.equalToSuperview().offset(0.7)
                make.height.equalTo(40)
            } else {
                make.top.equalToSuperview().offset(0)
                make.leading.equalToSuperview().offset(0)
                make.width.equalToSuperview().offset(0)
                make.height.equalTo(0)
            }
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        addProfileImageButton.snp.makeConstraints{ make in
            make.right.equalTo(profileImageView.snp.right)
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.height.equalTo(30)
            make.width.equalTo(addProfileImageButton.snp.height)
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
        
        indicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
}
