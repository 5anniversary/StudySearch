//
//  RegisterMemberTVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/13.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

import SnapKit
import Then

class RegisterMemberTVC: UITableViewCell {
    
    // MARK: - UI components
    
    let wantUserImageView = UIImageView()
    
    let wantUserNameLabel = UILabel()
    
    let registerButton = UIButton()

    // MARK: - Variables and Properties
    
    var wantUser: StudyUser?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helper
    
    func initCell () {
        
        _ = wantUserImageView.then {
            $0.image = UIImage(systemName: "person.crop.circle")
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .gray
        }
        
        _ = wantUserNameLabel.then {
            $0.text = wantUser?.name
            $0.font = UIFont.systemFont(ofSize: 18)
            $0.sizeToFit()
        }
        
        _ = registerButton.then {
            $0.setTitle("스터디원 추가", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            $0.makeRounded(cornerRadius: 15)
            $0.tintColor = .white
            $0.backgroundColor = .signatureColor
        }
    }
    
    func addContentView() {
        
        contentView.addSubview(wantUserImageView)
        contentView.addSubview(wantUserNameLabel)
        contentView.addSubview(registerButton)
        
        wantUserImageView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).inset(15)
            make.width.equalTo(55)
            make.height.equalTo(wantUserImageView.snp.width)
        }
        
        wantUserNameLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(wantUserImageView)
            make.left.equalTo(wantUserImageView.snp.right).offset(20)
        }
        
        registerButton.snp.makeConstraints{ make in
            make.centerY.equalTo(wantUserImageView)
            make.right.equalTo(contentView.snp.right).inset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
    }
}
