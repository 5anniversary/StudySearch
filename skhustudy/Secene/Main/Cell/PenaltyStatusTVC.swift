//
//  PenaltyStatusTVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

import SnapKit
import Then

class PenaltyStatusTVC: UITableViewCell {
    
    // MARK: - UI components
    
    let userImageView = UIImageView()
    let userNameLabel = UILabel()
    
    let statusView = UIView()
    let centerView = UIView()
    
    let absenceTextView = UITextView()
    let lateTextView = UITextView()
    let homeworkTextView = UITextView()

    // MARK: - Variables and Properties
    
    var studyUser: StudyUser?
    
    // MARK: - Life Cycle
    
    // MARK: - Helper
    
    func initCell () {
        
        _ = userImageView.then {
            $0.image = UIImage(systemName: "person.crop.circle")
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .gray
        }
        _ = userNameLabel.then {
            $0.text = studyUser?.name
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.sizeToFit()
        }
        
        let spacePenalty = CGFloat(5)
        _ = absenceTextView.then {
            // 줄 간격 조정을 위해 AttributedText 사용
            let style = NSMutableParagraphStyle()
            style.lineSpacing = spacePenalty
            style.alignment = .center
            let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            $0.attributedText = NSAttributedString(string: "결석 벌금\n2,000", attributes: attributes)
            
            $0.isScrollEnabled = false
        }
        _ = lateTextView.then {
            // 줄 간격 조정을 위해 AttributedText 사용
            let style = NSMutableParagraphStyle()
            style.lineSpacing = spacePenalty
            style.alignment = .center
            let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            $0.attributedText = NSAttributedString(string: "지각 벌금\n4,000", attributes: attributes)
            
            $0.isScrollEnabled = false
        }
        _ = homeworkTextView.then {
            // 줄 간격 조정을 위해 AttributedText 사용
            let style = NSMutableParagraphStyle()
            style.lineSpacing = spacePenalty
            style.alignment = .center
            let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            $0.attributedText = NSAttributedString(string: "과제 벌금\n5,000", attributes: attributes)
            
            $0.isScrollEnabled = false
        }
    }
    
    func addContentView() {
        
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        
        // 벌금 현황(3가지)
        contentView.addSubview(statusView)
        
        statusView.addSubview(absenceTextView)
        
        statusView.addSubview(centerView)
        centerView.addSubview(lateTextView)
        
        statusView.addSubview(homeworkTextView)
        
        
        userImageView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(23)
            make.width.equalTo(50)
            make.height.equalTo(userImageView.snp.width)
        }
        userNameLabel.snp.makeConstraints{ make in
            make.top.equalTo(userImageView.snp.bottom).offset(12)
            make.centerX.equalTo(userImageView)
            make.bottom.equalTo(contentView.snp.bottom).inset(14)
        }
        
        statusView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(userImageView.snp.right).offset(27)
            make.right.equalTo(contentView.snp.right).inset(23)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        absenceTextView.snp.makeConstraints{ make in
            make.centerY.equalTo(statusView)
            make.left.equalTo(statusView.snp.left)
        }
        
        centerView.snp.makeConstraints{ make in
            make.top.equalTo(statusView.snp.top)
            make.left.equalTo(absenceTextView.snp.right)
            make.right.equalTo(homeworkTextView.snp.left)
            make.bottom.equalTo(statusView.snp.bottom)
        }
        lateTextView.snp.makeConstraints{ make in
            make.centerX.equalTo(centerView)
            make.centerY.equalTo(centerView)
        }
        
        homeworkTextView.snp.makeConstraints{ make in
            make.centerY.equalTo(statusView)
            make.right.equalTo(statusView.snp.right)
        }
        
    }
   
}
