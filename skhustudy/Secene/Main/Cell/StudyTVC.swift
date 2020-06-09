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
    
//    @IBOutlet var studyImageView: UIImageView!
//
//    @IBOutlet var studyTitleLabel: UILabel!
//    @IBOutlet var studyCategoryLabel: UILabel!
//    @IBOutlet var studyInfoLabel: UILabel!
//    @IBOutlet var isPenalty: UILabel!
    
    let categoryButton = UIButton()
    let studyTitleLabel = UILabel()
    let isPenaltyLabel = UILabel()
    
    let studyImageView = UIImageView().then {
        $0.image = UIImage(named: "default_study_image")
        $0.contentMode = .scaleAspectFill
        $0.setRounded(radius: 30)
    }
    let studyInfoTextView = UITextView()
    
    let placeButton = UIButton()
    let memberButton = UIButton()
    
    
    // MARK: - Variables and Properties
    
    var studyInfo: StudyListData?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helper
    
    func initCell () {

        _ = categoryButton.then {
            $0.setTitle(studyInfo?.category, for: .normal)
            $0.backgroundColor = UIColor(red: 219, green: 219, blue: 219)
            $0.makeRounded(cornerRadius: 15)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = Font.nameLabel
            $0.isUserInteractionEnabled = false
        }
        _ = studyTitleLabel.then {
            $0.text = studyInfo?.name
            $0.font = Font.studyTitleLabel
            $0.sizeToFit()
        }
        _ = isPenaltyLabel.then {
            let isPenalty = studyInfo?.isFine ?? false == true
            if (isPenalty == true) {
                isPenaltyLabel.isHidden = false
            } else {
                isPenaltyLabel.isHidden = true
            }
            $0.text = "벌금"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        
        _ = studyInfoTextView.then {
            $0.text = studyInfo?.content
            $0.font = Font.studyContentsLabel
            $0.isUserInteractionEnabled = false
            $0.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5) // 기본 설정 값인 0이 좌우 여백이 있기 때문에 조정 필요
        }
        
        _ = memberButton.then {
            $0.contentHorizontalAlignment = .left
            
            $0.setImage(UIImage(systemName: "person"), for: .normal)
            $0.tintColor = .black
            
            let userLimitStr = String(studyInfo?.userLimit ?? 0)
            $0.setTitle(userLimitStr, for: .normal)
            $0.titleLabel?.font = Font.studyContentsLabel
            $0.setTitleColor(.black, for: .normal)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            $0.isUserInteractionEnabled = false
        }
        _ = placeButton.then {
            $0.contentHorizontalAlignment = .left
            
            $0.setImage(UIImage(named: "place_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .black
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 170)
            
            $0.setTitle(studyInfo?.location, for: .normal)
            $0.titleLabel?.font = Font.studyContentsLabel
            $0.setTitleColor(.black, for: .normal)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            $0.isUserInteractionEnabled = false
        }
    }
    
    func addContentView() {
        
        contentView.addSubview(categoryButton)
        contentView.addSubview(studyTitleLabel)
        contentView.addSubview(isPenaltyLabel)
        
        contentView.addSubview(studyImageView)
        contentView.addSubview(studyInfoTextView)
        
        contentView.addSubview(memberButton)
        contentView.addSubview(placeButton)
        
        
        categoryButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(50)
        }
        studyTitleLabel.snp.makeConstraints{ (make) in
            make.centerY.equalTo(categoryButton)
            make.left.equalTo(categoryButton.snp.right).offset(20)
        }
        
        isPenaltyLabel.snp.makeConstraints{ (make) in
            make.centerY.equalTo(categoryButton)
            make.right.equalToSuperview().inset(20)
        }
        
        studyImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(categoryButton.snp.bottom).offset(10)
            make.centerX.equalTo(categoryButton)
            make.width.equalTo(60)
            make.height.equalTo(studyImageView.snp.width)
            
//            make.bottom.equalToSuperview().inset(20)
        }
        studyInfoTextView.snp.makeConstraints{ (make) in
            make.top.equalTo(studyTitleLabel.snp.bottom).offset(15)
            make.left.equalTo(studyTitleLabel.snp.left)
            make.right.equalTo(isPenaltyLabel.snp.right)
            make.height.equalTo(45)
        }
        
        memberButton.snp.makeConstraints{ make in
            make.top.equalTo(studyInfoTextView.snp.bottom)
            make.left.equalTo(studyInfoTextView.snp.left)
            make.bottom.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
        placeButton.snp.makeConstraints{ make in
            make.top.equalTo(memberButton.snp.top)
            make.left.equalTo(memberButton.snp.right)
            make.bottom.equalTo(memberButton.snp.bottom)
//            make.width.equalTo(120)
            make.right.equalTo(isPenaltyLabel.snp.right)
            make.height.equalTo(memberButton.snp.height)
        }
    }

}
