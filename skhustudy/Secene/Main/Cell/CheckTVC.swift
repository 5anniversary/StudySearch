//
//  CheckTVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

import SnapKit
import Then

class CheckTVC: UITableViewCell {
    
    // MARK: - UI components
    
    let userImageView = UIImageView()
    
    let userNameLabel = UILabel()
    
    let absenceButton = UIButton()
    let lateButton = UIButton()
    let homeworkButton = UIButton()

    // MARK: - Variables and Properties
    
    var studyUser: StudyUser?
    
    var isClickedAbsence = false
    var isClickedLate = false
    var isClickedHomework = false
    
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
        
        _ = absenceButton.then {
            $0.setTitle("결석", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            $0.makeRounded(cornerRadius: 15)
            $0.tintColor = .white
            $0.backgroundColor = .signatureColor
        }
        _ = lateButton.then {
            $0.setTitle("지각", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            $0.makeRounded(cornerRadius: 15)
            $0.tintColor = .white
            $0.backgroundColor = .signatureColor
        }
        _ = homeworkButton.then {
            $0.setTitle("과제 미제출", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            $0.makeRounded(cornerRadius: 15)
            $0.tintColor = .white
            $0.backgroundColor = .signatureColor
        }
    }
    
    func addContentView() {
        
        contentView.addSubview(userImageView)
        
        contentView.addSubview(userNameLabel)
        
        contentView.addSubview(absenceButton)
        contentView.addSubview(lateButton)
        contentView.addSubview(homeworkButton)
        
        
        userImageView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).inset(15)
            make.width.equalTo(90)
            make.height.equalTo(userImageView.snp.width)
        }
        
        userNameLabel.snp.makeConstraints{ make in
            make.top.equalTo(userImageView.snp.top).offset(5)
            make.left.lessThanOrEqualTo(userImageView.snp.right).offset(25)
        }
        
        absenceButton.snp.makeConstraints{ make in
            make.left.equalTo(userNameLabel.snp.left)
            make.bottom.equalTo(userImageView.snp.bottom).inset(5)
            make.width.equalTo(72)
            make.height.equalTo(30)
        }
        lateButton.snp.makeConstraints{ make in
            make.left.equalTo(absenceButton.snp.right).offset(15)
            make.centerY.equalTo(absenceButton)
            make.width.equalTo(absenceButton.snp.width)
            make.height.equalTo(absenceButton.snp.height)
        }
        homeworkButton.snp.makeConstraints{ make in
            make.left.equalTo(lateButton.snp.right).offset(15)
            make.right.equalTo(contentView.snp.right).inset(15)
            make.centerY.equalTo(absenceButton)
            make.width.equalTo(absenceButton.snp.width)
            make.height.equalTo(absenceButton.snp.height)
        }
        
    }
    
    func updateButtonStatus() {
        if isClickedAbsence == true {
            absenceButton.alpha = 1.0
        } else {
            absenceButton.alpha = 0.5
        }
        
        if isClickedLate == true {
            lateButton.alpha = 1.0
        } else {
            lateButton.alpha = 0.5
        }
        
        if isClickedHomework == true {
            homeworkButton.alpha = 1.0
        } else {
            homeworkButton.alpha = 0.5
        }
    }
}
