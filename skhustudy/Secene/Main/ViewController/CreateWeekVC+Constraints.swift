//
//  CreateWeekVC+Constraints.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SnapKit

extension CreateWeekVC {
    func addSubView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(roundLabel)
        containerView.addSubview(roundTextField)
        containerView.addSubview(dateLabel)
        containerView.addSubview(dateTextField)
        containerView.addSubview(subjectLabel)
        containerView.addSubview(subjectTextField)
        containerView.addSubview(locationLabel)
        containerView.addSubview(locationTextField)
        containerView.addSubview(memoLabel)
        containerView.addSubview(memoTextView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        roundLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(15)
        }
        
        roundTextField.snp.makeConstraints { make in
            make.top.equalTo(roundLabel)
            make.left.equalTo(roundLabel.snp.right).offset(20)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(roundLabel)
        }
        
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(roundLabel.snp.bottom).offset(35)
            make.left.equalTo(roundLabel)
            make.height.equalTo(roundLabel)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(dateLabel)
            make.left.equalTo(dateLabel.snp.right).offset(20)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(roundLabel)
        }
        
        
        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(35)
            make.left.equalTo(roundLabel)
            make.height.equalTo(roundLabel)
        }
        
        subjectTextField.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel)
            make.left.equalTo(subjectLabel.snp.right).offset(20)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(roundLabel)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel.snp.bottom).offset(35)
            make.left.equalTo(roundLabel)
            make.height.equalTo(roundLabel)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(locationLabel)
            make.left.equalTo(locationLabel.snp.right).offset(20)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(roundLabel)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(35)
            make.left.equalTo(roundLabel)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(30)
            make.left.equalTo(memoLabel.snp.right).offset(20)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.bottom.lessThanOrEqualTo(containerView).offset(-40)
        }

        
    }
}
