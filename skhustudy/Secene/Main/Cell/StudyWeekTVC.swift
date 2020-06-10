//
//  StudyWeekTVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/03.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation
import UIKit

import SnapKit
import Then

class StudyWeekTVC: UITableViewCell {
    
    // MARK: - UI components
  
    let numberLabel = UILabel()
    let dateLabel = UILabel()
    
    let titleLabel = UILabel()
    
    let placeButton = UIButton()
    let placeImageView = UIImageView()
    
    // MARK: - Variables and Properties
    
    var studyChapterInfo: ChapterListData?
    var studyOrder: Int?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helper
    
    func initCell () {
        
        _ = numberLabel.then {
            $0.text = String(studyOrder ?? 0) + " 번째 스터디"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        _ = dateLabel.then {
            var date = studyChapterInfo?.date
            date = date?.replacingOccurrences(of: "-", with: ".")
            $0.text = date
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.textColor = UIColor(red: 137, green: 137, blue: 137)
            $0.sizeToFit()
        }
        
        _ = titleLabel.then {
           $0.text = studyChapterInfo?.title
           $0.font = Font.studyContentsLabel
           $0.sizeToFit()
           }
        
        _ = placeButton.then {
            $0.setTitle(studyChapterInfo?.place, for: .normal)
            $0.titleLabel?.font = Font.studyContentsLabel
            $0.setTitleColor(UIColor(red: 72, green: 72, blue: 72), for: .normal)
            $0.titleLabel?.textAlignment = .right

            $0.isUserInteractionEnabled = false
        }
        _ = placeImageView.then {
            $0.image = UIImage(named: "place_icon")?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = UIColor(red: 72, green: 72, blue: 72)
        }
        
    }
    
    func addContentView() {
        
        contentView.addSubview(numberLabel)
        contentView.addSubview(dateLabel)
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(placeButton)
        contentView.addSubview(placeImageView)
        
        
        numberLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
        }
        dateLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(numberLabel)
            make.right.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(numberLabel.snp.bottom).offset(20)
            make.left.equalTo(numberLabel.snp.left)
            make.bottom.equalToSuperview().inset(10)
        }
        
        placeButton.snp.makeConstraints{ make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(dateLabel.snp.right)
            make.height.equalTo(40)
        }
        placeImageView.snp.makeConstraints{ make in
            make.centerY.equalTo(placeButton)
            make.right.equalTo(placeButton.snp.left).offset(-5)
            make.width.equalTo(15)
            make.height.equalTo(placeImageView.snp.width)
        }
    }
    
}
