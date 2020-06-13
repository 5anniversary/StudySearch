//
//  AddUserCategoryCell.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/22.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SnapKit
import Then

class AddUserCategoryCell: UICollectionViewCell {
    
    static var identifier = "CategoryCell"
    
    override var isSelected: Bool {
        didSet {
            self.alpha = isSelected ? 0.5 : 1.0
        }
    }
    
    let categoryLabel = UILabel().then {
        $0.textColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: 18.0)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubview() {
        self.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        
        gradient.colors = [
            UIColor(red: 193, green: 59, blue: 59).cgColor,
            UIColor(red: 186, green: 196, blue: 198).cgColor,
        ]
        
        gradient.startPoint = .init(x: 0.0, y: 0.0)
        gradient.endPoint = .init(x: 1.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
        
        
    }
    
}
