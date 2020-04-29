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
        view.addSubview(roundLabel)
        view.addSubview(roundTextField)
        view.addSubview(dateLabel)
        view.addSubview(dateTextField)
        view.addSubview(subjectLabel)
        view.addSubview(subjectTextField)
        view.addSubview(locationLabel)
        view.addSubview(locationTextField)
        view.addSubview(memoLabel)
        view.addSubview(memoTextField)

        roundLabel.snp.makeConstraints { make in
            make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(50)
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
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(30)
            make.left.equalTo(memoLabel.snp.right).offset(20)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(33)
        }

        
    }
}
