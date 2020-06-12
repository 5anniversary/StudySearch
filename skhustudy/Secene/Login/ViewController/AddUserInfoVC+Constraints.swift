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
        
        containerView.addSubview(profileImageView)
        containerView.addSubview(addProfileImageButton)
        
        containerView.addSubview(nicknameLabel)
        containerView.addSubview(nicknameTextField)
        
        containerView.addSubview(ageLabel)
        containerView.addSubview(ageTextField)
        
        containerView.addSubview(genderLabel)
        containerView.addSubview(genderTextField)
        
        containerView.addSubview(locationLabel)
        containerView.addSubview(locationTextField)
        
        containerView.addSubview(selfIntroLabel)
        containerView.addSubview(textViewContainer)
        textViewContainer.addSubview(selfIntroductionTextView)
        
        containerView.addSubview(indicator)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
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
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(17)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        addProfileImageButton.snp.makeConstraints{ make in
            make.right.equalTo(profileImageView.snp.right)
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.height.equalTo(30)
            make.width.equalTo(addProfileImageButton.snp.height)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(25)
            make.left.equalTo(nicknameTextField)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nicknameLabel.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(40)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(25)
            make.left.equalTo(nicknameTextField)
        }
        ageTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ageLabel.snp.bottom)
            make.width.equalTo(nicknameTextField)
            make.height.equalTo(nicknameTextField)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(ageTextField.snp.bottom).offset(25)
            make.left.equalTo(nicknameTextField)
        }
        genderTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(genderLabel.snp.bottom)
            make.width.equalTo(nicknameTextField)
            make.height.equalTo(nicknameTextField)
        }
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(genderTextField.snp.bottom).offset(25)
            make.left.equalTo(nicknameTextField)
        }
        locationTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom)
            make.width.equalTo(nicknameTextField)
            make.height.equalTo(nicknameTextField)
        }
        selfIntroLabel.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(25)
            make.left.equalTo(nicknameTextField)
        }
        
        
        textViewContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(selfIntroLabel.snp.bottom).offset(10)
            make.width.equalTo(nicknameTextField)
            make.bottom.lessThanOrEqualTo(containerView)
        }
        
        selfIntroductionTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(-2.5)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
}
