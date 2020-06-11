//
//  TabCVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/06/10.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class TabCVC: UICollectionViewCell {
    static let reuseIdentifire = "TabBarCell"
    
    let titleLabel = UILabel().then {
        $0.font = Font.titleLabel
    }
    
    func setTitle(title: String){
        
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                titleLabel.textColor = .signatureColor
                titleLabel.font = Font.titleLabel
            } else {
                titleLabel.textColor = .veryLightPink
                titleLabel.font = Font.titleLabel
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(25)
        }

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
    
}
