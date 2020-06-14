//
//  PenaltyStatusHeaderView.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

import SnapKit
import Then

import SwiftKeychainWrapper

class PenaltyStatusHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - UI components
    
    let containerView = UIView()
    let centerView = UIView()
    
    let absenceTextView = UITextView()
    let lateTextView = UITextView()
    let homeworkTextView = UITextView()
    
    // MARK: - Variables and Properties
    
    var studyUser: StudyUser?
    
    // MARK: - Life Cycle
    
    // MARK: - Helper
    
    func initHeaderView () {
        
        let spacePenalty = CGFloat(10)
        _ = absenceTextView.then {
            // 줄 간격 조정을 위해 AttributedText 사용
            let style = NSMutableParagraphStyle()
            style.lineSpacing = spacePenalty
            style.alignment = .center
            let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            $0.attributedText = NSAttributedString(string: "결석 벌금\n1,000", attributes: attributes)
            
            $0.isScrollEnabled = false
        }
        _ = lateTextView.then {
            // 줄 간격 조정을 위해 AttributedText 사용
            let style = NSMutableParagraphStyle()
            style.lineSpacing = spacePenalty
            style.alignment = .center
            let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            $0.attributedText = NSAttributedString(string: "지각 벌금\n1,000", attributes: attributes)
            
            $0.isScrollEnabled = false
        }
        _ = homeworkTextView.then {
            // 줄 간격 조정을 위해 AttributedText 사용
            let style = NSMutableParagraphStyle()
            style.lineSpacing = spacePenalty
            style.alignment = .center
            let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            $0.attributedText = NSAttributedString(string: "과제 벌금\n1,000", attributes: attributes)
            
            $0.isScrollEnabled = false
        }
    }
    
    func addContentView() {
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(absenceTextView)
        
        containerView.addSubview(centerView)
        centerView.addSubview(lateTextView)
        
        containerView.addSubview(homeworkTextView)
        
        
        let leftAndRightSpace = 45
        containerView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(leftAndRightSpace)
            make.right.equalTo(contentView.snp.right).inset(leftAndRightSpace)
            make.bottom.equalTo(contentView.snp.bottom).inset(15)
        }
        
        absenceTextView.snp.makeConstraints{ make in
            make.top.equalTo(containerView.snp.top)
            make.left.equalTo(containerView.snp.left)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        
        centerView.snp.makeConstraints{ make in
            make.top.equalTo(containerView.snp.top)
            make.left.equalTo(absenceTextView.snp.right)
            make.right.equalTo(homeworkTextView.snp.left)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        lateTextView.snp.makeConstraints{ make in
            make.centerY.equalTo(centerView)
            make.centerX.equalTo(centerView)
        }
        
        homeworkTextView.snp.makeConstraints{ make in
            make.top.equalTo(containerView.snp.top)
            make.right.equalTo(containerView.snp.right)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        
    }
    
}
