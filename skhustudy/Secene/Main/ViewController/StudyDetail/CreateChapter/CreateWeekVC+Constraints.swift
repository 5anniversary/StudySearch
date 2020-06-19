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
        
        // Add SubView
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        // 챕터 제목
        containerView.addSubview(chapterTitleLabel)
        containerView.addSubview(chapterTitleTextField)
        
        // 모임 장소
        containerView.addSubview(placeLabel)
        containerView.addSubview(placeTextField)
        
        // 모임 날짜
        containerView.addSubview(dateLabel)
        containerView.addSubview(dateTextField)
        
        // 챕터 내용
        containerView.addSubview(chapterContentLabel)
        containerView.addSubview(chapterContentTextView)
        containerView.addSubview(underLineView)
        
        // 예약 버튼
        containerView.addSubview(bookingButton)
        
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
        // 챕터 제목
        let betweenDifferentArea = 30
        let betweenLabelAndTextField = 20
        let betweenLeftAndRightContainerView = 25
        // 스터디 제목
        chapterTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
        }
        chapterTitleTextField.snp.makeConstraints{ make in
            make.top.equalTo(chapterTitleLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        
        // 모임 장소
        placeLabel.snp.makeConstraints{ make in
            make.top.equalTo(chapterTitleTextField.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
        }
        placeTextField.snp.makeConstraints{ make in
            make.top.equalTo(placeLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        
        // 모임 날짜
        dateLabel.snp.makeConstraints{ make in
            make.top.equalTo(placeTextField.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
        }
        dateTextField.snp.makeConstraints{ make in
            make.top.equalTo(dateLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        
        // 챕터 내용
        chapterContentLabel.snp.makeConstraints{ make in
            make.top.equalTo(dateTextField.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
        }
        chapterContentTextView.snp.makeConstraints{ make in
            make.top.equalTo(chapterContentLabel.snp.bottom).offset(betweenLabelAndTextField)
            make.left.equalTo(containerView.snp.left).offset(betweenLeftAndRightContainerView)
            make.right.equalTo(containerView.snp.right).inset(betweenLeftAndRightContainerView)
        }
        underLineView.snp.makeConstraints{ make in
            make.top.equalTo(chapterContentTextView.snp.bottom).offset(1)
            make.centerX.equalTo(chapterContentTextView)
            make.width.equalTo(chapterContentTextView)
            make.height.equalTo(1)
        }
        
        // 예약 버튼
        bookingButton.snp.makeConstraints{ make in
            make.top.equalTo(underLineView.snp.bottom).offset(betweenDifferentArea)
            make.left.equalTo(betweenLeftAndRightContainerView)
            make.bottom.lessThanOrEqualTo(containerView.snp.bottom).inset(20)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
    }
}
