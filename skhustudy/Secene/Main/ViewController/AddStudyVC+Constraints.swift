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
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(studyImageView)
        studyImageView.addSubview(addStudyImageButton)
        
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
    }
    
}
