//
//  AddStudyVC+Constraints.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/07.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

extension AddStudyVC {
    
    func addSubView() {
        
        // Add SubView
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        // 스터디 이미지 설정
        containerView.addSubview(studyImageView)
        containerView.addSubview(addStudyImageButton)
        
        // 스터디 제목
        containerView.addSubview(studyTitleLabel)
        containerView.addSubview(studyTitleTextField)
        
        // 카테고리
        containerView.addSubview(categoryLabel)
        containerView.addSubview(categoryTextField)
        
        // 소개
        containerView.addSubview(introduceLabel)
        containerView.addSubview(introduceTextView)
        containerView.addSubview(underLineView)
        
        // 장소
        containerView.addSubview(placeLabel)
        containerView.addSubview(placeTextField)
        
        // 벌금 여부
        containerView.addSubview(penaltyLabel)
        containerView.addSubview(penaltyYesButton)
        containerView.addSubview(penaltyNoButton)
        
        containerView.addSubview(penaltyView)
        
        penaltyView.addSubview(penaltyAttendanceLabel)
        penaltyView.addSubview(penaltyAttendanceTextField)
        
        penaltyView.addSubview(penaltyLateLabel)
        penaltyView.addSubview(penaltyLateTextField)
        
        penaltyView.addSubview(penaltyHomeworkLabel)
        penaltyView.addSubview(penaltyHomeworkTextField)
        
        // 모집 기간
        containerView.addSubview(termLabel)
        containerView.addSubview(termYesButton)
        containerView.addSubview(termNoButton)
        
        containerView.addSubview(termView)
        
        termView.addSubview(termStartLabel)
        termView.addSubview(termStartTextField)
        
        termView.addSubview(termEndLabel)
        termView.addSubview(termEndTextField)
        
        // 모집 인원
        containerView.addSubview(userLimitLabel)
        containerView.addSubview(userLimitTextField)
        
    }
    
    func makeConstraints() {
        
        // Add ScrollView with ContainerView
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(scrollView.snp.height)
        }
        
        
        // Make Constraints
        // 스터디 이미지 설정
        studyImageView.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(containerView.snp.top).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(studyImageView.snp.width)
        }
        addStudyImageButton.snp.makeConstraints{ make in
            make.right.equalTo(studyImageView.snp.right)
            make.bottom.equalTo(studyImageView.snp.bottom)
            make.width.equalTo(30)
            make.height.equalTo(addStudyImageButton.snp.width)
        }
        
        
        let betweenDifferentArea = 30
        let betweenLabelAndTextField = 20
        let betweenLeftAndRightContainerView = 25
        let betweenButtons = 20
        let buttonWidth = 80
        // 스터디 제목
        studyTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(studyImageView.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
        }
        studyTitleTextField.snp.makeConstraints{ make in
            make.top.equalTo(studyTitleLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        
        // 카테고리
        categoryLabel.snp.makeConstraints{ make in
            make.top.equalTo(studyTitleTextField.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
        }
        categoryTextField.snp.makeConstraints{ make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        
        // 소개
        introduceLabel.snp.makeConstraints{ make in
            make.top.equalTo(categoryTextField.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
        }
        introduceTextView.snp.makeConstraints{ make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        underLineView.snp.makeConstraints{ make in
            make.top.equalTo(introduceTextView.snp.bottom).offset(1)
            make.centerX.equalTo(introduceTextView)
            make.width.equalTo(introduceTextView)
            make.height.equalTo(1)
        }
        
        // 장소
        placeLabel.snp.makeConstraints{ make in
            make.top.equalTo(underLineView.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
        }
        placeTextField.snp.makeConstraints{ make in
            make.top.equalTo(placeLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        
        // 벌금 여부
        penaltyLabel.snp.makeConstraints{ make in
            make.top.equalTo(placeTextField.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
        }
        penaltyYesButton.snp.makeConstraints{ make in
            make.top.equalTo(penaltyLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.width.equalTo(buttonWidth)
        }
        penaltyNoButton.snp.makeConstraints{ make in
            make.top.equalTo(penaltyLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(penaltyYesButton.snp.right).offset(betweenButtons)
            make.width.equalTo(buttonWidth)
        }
        
        penaltyView.snp.makeConstraints{ make in
            make.top.equalTo(penaltyYesButton.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        
        penaltyAttendanceLabel.snp.makeConstraints{ make in
            make.top.equalTo(penaltyView.snp.top)
            make.left.equalTo(penaltyView.snp.left)
        }
        penaltyAttendanceTextField.snp.makeConstraints{ make in
            make.top.equalTo(penaltyAttendanceLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(penaltyView.snp.left)
            make.right.equalTo(penaltyView.snp.right)
        }
        
        penaltyLateLabel.snp.makeConstraints{ make in
            make.top.equalTo(penaltyAttendanceTextField.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(penaltyView.snp.left)
        }
        penaltyLateTextField.snp.makeConstraints{ make in
            make.top.equalTo(penaltyLateLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(penaltyView.snp.left)
            make.right.equalTo(penaltyView.snp.right)
        }
        
        penaltyHomeworkLabel.snp.makeConstraints{ make in
            make.top.equalTo(penaltyLateTextField.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(penaltyView.snp.left)
        }
        penaltyHomeworkTextField.snp.makeConstraints{ make in
            make.top.equalTo(penaltyHomeworkLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(penaltyView.snp.left)
            make.right.equalTo(penaltyView.snp.right)
            make.bottom.equalTo(penaltyView.snp.bottom)
        }
        
        // 모집 기간
        termLabel.snp.makeConstraints{ make in
            make.top.equalTo(penaltyView.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
        }
        termYesButton.snp.makeConstraints{ make in
            make.top.equalTo(termLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.width.equalTo(buttonWidth)
        }
        termNoButton.snp.makeConstraints{ make in
            make.top.equalTo(termLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(termYesButton.snp.right).offset(betweenButtons)
            make.width.equalTo(buttonWidth)
        }
        
        termView.snp.makeConstraints{ make in
            make.top.equalTo(termYesButton.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        
        termStartLabel.snp.makeConstraints{ make in
            make.top.equalTo(termView.snp.top)
            make.left.equalTo(termView.snp.left)
        }
        termStartTextField.snp.makeConstraints{ make in
            make.top.equalTo(termStartLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(termView.snp.left)
            make.right.equalTo(termView.snp.right)
        }
        
        termEndLabel.snp.makeConstraints{ make in
            make.top.equalTo(termStartTextField.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(termView.snp.left)
        }
        termEndTextField.snp.makeConstraints{ make in
            make.top.equalTo(termEndLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(termView.snp.left)
            make.right.equalTo(termView.snp.right)
            make.bottom.equalTo(termView.snp.bottom)
        }
        
        // 모집 인원
        userLimitLabel.snp.makeConstraints{ make in
            make.top.equalTo(termView.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        userLimitTextField.snp.makeConstraints{ make in
            make.top.equalTo(userLimitLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
            make.bottom.equalTo(containerView.snp.bottom).inset(30)
        }
    }
    
}
