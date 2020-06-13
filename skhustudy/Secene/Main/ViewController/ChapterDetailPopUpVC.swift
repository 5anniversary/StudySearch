//
//  chapterDetailPopUpVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/13.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

import Then
import SnapKit

class ChapterDetailPopUpVC: UIViewController {
    
    // MARK: - UI components

    let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.setRounded(radius: 20)
    }
    
    let dismissButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .signatureColor
        $0.addTarget(self, action: #selector(didTapDismissButton(_:)), for: .touchUpInside)
    }
    
    let numberLabel = UILabel().then {
        $0.text = "1번째 스터디"
        $0.font = UIFont.boldSystemFont(ofSize: 13)
        $0.textColor = .lightGray
        $0.sizeToFit()
    }
    let titleLabel = UILabel().then {
        $0.text = "타이틀"
        $0.font = Font.titleLabel
        $0.textColor = .black
        $0.sizeToFit()
    }
    
    let dateTagLabel = UILabel().then {
//        var date = studyChapterInfo?.date
//        date = date?.replacingOccurrences(of: "-", with: ".")
        $0.text = "날짜"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .black
        $0.sizeToFit()
    }
    let dateLabel = UILabel().then {
//        var date = studyChapterInfo?.date
//        date = date?.replacingOccurrences(of: "-", with: ".")
        $0.text = "2020.06.20"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .black
        $0.sizeToFit()
    }
    let placeTagLabel = UILabel().then {
        $0.text = "장소"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .black
        $0.sizeToFit()
        }
        let placeLabel = UILabel().then {
        $0.text = "서울 강남"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .black
        $0.sizeToFit()
        }
    let checkButton = UIButton().then {
        $0.setTitle("체크 하기", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.makeRounded(cornerRadius: 15)
        $0.tintColor = .white
        $0.backgroundColor = .signatureColor
    }
    
    let contentLabel = UILabel().then {
        $0.text = "내용"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .black
        $0.sizeToFit()
    }
    let contentTextView = UITextView().then {
        $0.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        $0.sizeToFit()
        $0.isScrollEnabled = false
        $0.font = Font.studyContentsLabel
        $0.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5) // 기본 설정 값인 0이 좌우 여백이 있기 때문에 조정 필요
        $0.allowsEditingTextAttributes = true
    }
    
    // MARK: - Variables and Properties

    // MARK: - dummy data

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up View - background alpha
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        addSubView()
    }
    
    func addSubView() {
        
        // Add SubView
        view.addSubview(popUpView)
        
        popUpView.addSubview(dismissButton)
        
        popUpView.addSubview(numberLabel)
        popUpView.addSubview(titleLabel)
        
        popUpView.addSubview(dateTagLabel)
        popUpView.addSubview(dateLabel)
        
        popUpView.addSubview(placeTagLabel)
        popUpView.addSubview(placeLabel)
        
        popUpView.addSubview(checkButton)
        
        popUpView.addSubview(contentLabel)
        popUpView.addSubview(contentTextView)
        
        
        // Make Constraints
        popUpView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(88)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            
//            var tabBarHeight = tabBarController?.tabBar.frame.size.height ?? 0
//            tabBarHeight = tabBarHeight + CGFloat(50.0)
            make.bottom.equalToSuperview().inset(120)
        }
        
        dismissButton.snp.makeConstraints{ make in
            make.top.equalTo(popUpView.snp.top).offset(10)
            make.right.equalTo(popUpView.snp.right).inset(10)
            make.width.equalTo(40)
            make.height.equalTo(dismissButton.snp.width)
        }
        
        let betweenPopUpView = 20
        numberLabel.snp.makeConstraints{ make in
            make.top.equalTo(dismissButton.snp.bottom).inset(20)
            make.left.equalTo(popUpView.snp.left).offset(betweenPopUpView)
        }
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(numberLabel.snp.bottom).offset(10)
            make.left.equalTo(popUpView.snp.left).offset(betweenPopUpView)
        }
        
        dateTagLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(popUpView.snp.left).offset(betweenPopUpView)
        }
        dateLabel.snp.makeConstraints{ make in
            make.top.equalTo(dateTagLabel.snp.bottom).offset(15)
            make.left.equalTo(popUpView.snp.left).offset(betweenPopUpView)
        }
        
        placeTagLabel.snp.makeConstraints{ make in
            make.top.equalTo(dateTagLabel.snp.top)
            make.left.equalTo(placeLabel.snp.left)
        }
        placeLabel.snp.makeConstraints{ make in
            make.top.equalTo(dateLabel.snp.top)
            make.left.equalTo(dateLabel.snp.right).offset(30)
        }
        
        checkButton.snp.makeConstraints{ make in
            make.top.equalTo(placeTagLabel.snp.bottom)
            make.right.equalTo(popUpView.snp.right).inset(betweenPopUpView)
            make.width.equalTo(86)
            make.height.equalTo(31)
        }
        
        contentLabel.snp.makeConstraints{ make in
            make.top.equalTo(dateLabel.snp.bottom).offset(25)
            make.left.equalTo(popUpView.snp.left).offset(betweenPopUpView)
        }
        contentTextView.snp.makeConstraints{ make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.equalTo(popUpView.snp.left).offset(betweenPopUpView)
            make.right.equalTo(popUpView.snp.right).inset(betweenPopUpView)
            make.bottom.lessThanOrEqualTo(popUpView.snp.bottom).inset(betweenPopUpView)
        }
        
    }
    
    @objc func didTapDismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
