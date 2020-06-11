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
        view.addSubview(selectCategoryCollectionView)
    
        selectCategoryCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
          
    }
}
