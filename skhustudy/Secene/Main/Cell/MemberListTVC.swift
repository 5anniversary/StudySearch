//
//  MemberListTVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/13.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

import SnapKit
import Then

class MemberListTVC: UITableViewCell {
    
    // MARK: - UI components
    
    let userImageView = UIImageView()
    
    let userNameLabel = UILabel()

    // MARK: - Variables and Properties
    
    var studyUser: StudyUser?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helper
    
    func initCell () {
        
        _ = userImageView.then {
            $0.image = UIImage(systemName: "person.crop.circle")
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .gray
        }
        
        _ = userNameLabel.then {
            $0.text = studyUser?.name
            $0.font = UIFont.systemFont(ofSize: 18)
            $0.sizeToFit()
        }
        
    }
    
    func addContentView() {
        
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        
        userImageView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).inset(15)
            make.width.equalTo(55)
            make.height.equalTo(userImageView.snp.width)
        }
        
        userNameLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(userImageView)
            make.left.equalTo(userImageView.snp.right).offset(20)
        }
        
    }
}
