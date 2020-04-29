//
//  StudyTVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/04/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation
import UIKit

import SnapKit
import Then

class StudyTVC: UITableViewCell {
    
    // MARK: - UI components
    
    @IBOutlet var studyImageView: UIImageView!
    
    @IBOutlet var studyTitleLabel: UILabel!
    @IBOutlet var studyCategoryLabel: UILabel!
    @IBOutlet var studyInfoLabel: UILabel!
    @IBOutlet var isPenalty: UILabel!
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helper
    
    func initCell () {

        studyTitleLabel.then {
            $0.text = "팀쿡과 함께하는 스위프트 기초"
            $0.font = Font.studyTitleLabel
            $0.sizeToFit()
        }
        studyCategoryLabel.then {
            $0.text = "#iOS #Swift"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        studyInfoLabel.then {
            $0.text = "산호세, CA / 5명"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        isPenalty.then {
            $0.text = "벌금제도 있음"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        
        studyImageView.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(70)
            make.height.equalTo(studyImageView.snp.width)
        }
        
        studyTitleLabel.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(studyImageView.snp.right).offset(10)
        }
        studyCategoryLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(studyTitleLabel.snp.bottom).offset(5)
            make.left.equalTo(studyTitleLabel.snp.left)
        }
        studyInfoLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(studyCategoryLabel.snp.bottom).offset(5)
            make.left.equalTo(studyTitleLabel.snp.left)
        }
        isPenalty.snp.makeConstraints{ (make) in
            make.top.equalTo(studyInfoLabel.snp.bottom).offset(5)
            make.left.equalTo(studyTitleLabel.snp.left)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
}
