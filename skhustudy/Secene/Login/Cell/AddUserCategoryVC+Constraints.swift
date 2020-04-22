//
//  AddUserCategoryVC+Constraints.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/22.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SnapKit

extension AddUserCategoryVC {
    func addSubView() {
        view.addSubview(label)
        view.addSubview(selectCategoryCollectionView)
        view.addSubview(completeButton)
        
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        selectCategoryCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(selectCategoryCollectionView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
    }
}
