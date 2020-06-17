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

    let popUpView = UIView()
    
    let dismissButton = UIButton()
    
    let numberLabel = UILabel()
    
    let titleLabel = UILabel()
    
    let dateTagLabel = UILabel()
    let dateLabel = UILabel()
    
    let placeTagLabel = UILabel()
    let placeLabel = UILabel()
    
    let checkButton = UIButton()
    
    let contentLabel = UILabel()
    let contentTextView = UITextView()
    
    // MARK: - Variables and Properties

    var studyDetailVC: UIViewController?
    
    var studyUserList: [StudyUser]?
    var chapterListData: ChapterListData?
    var studyOrder: Int?
    
    // MARK: - dummy data

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up View - background alpha
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        initPopUpView()
        addSubView()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDismissButton(_:))))
    }
    
    func initPopUpView() {
        
        // 팝업 뷰 디자인 설정
        _ = popUpView.then {
            $0.backgroundColor = .white
            $0.setRounded(radius: 20)
        }
        
        // 나가기 버튼
        _ = dismissButton.then {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .signatureColor
            $0.addTarget(self, action: #selector(didTapDismissButton(_:)), for: .touchUpInside)
        }
        
        // n번쨰 스터디
        _ = numberLabel.then {
            $0.text = String(studyOrder ?? 0) + "번째 스터디"
            $0.font = UIFont.boldSystemFont(ofSize: 13)
            $0.textColor = .lightGray
            $0.sizeToFit()
        }
        
        // 챕터 제목
        _ = titleLabel.then {
            $0.text = chapterListData?.title
            $0.font = Font.titleLabel
            $0.textColor = .black
            $0.sizeToFit()
        }
        
        // 날짜
        _ = dateTagLabel.then {
            $0.text = "날짜"
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.textColor = .black
            $0.sizeToFit()
        }
        _ = dateLabel.then {
            var date = chapterListData?.date
            date = date?.replacingOccurrences(of: "-", with: ".")
            $0.text = date
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.textColor = .black
            $0.sizeToFit()
        }
        
        // 장소
        _ = placeTagLabel.then {
            $0.text = "장소"
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.textColor = .black
            $0.sizeToFit()
        }
        _ = placeLabel.then {
            $0.text = chapterListData?.place
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.textColor = .black
            $0.sizeToFit()
        }
        
        // 체크 버튼
        _ = checkButton.then {
            $0.setTitle("체크 하기", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            $0.makeRounded(cornerRadius: 15)
            $0.tintColor = .white
            $0.backgroundColor = .signatureColor
            $0.addTarget(self, action: #selector(didTapCheckButton(_:)), for: .touchUpInside)
        }
        
        // 챕터 내용
        _ = contentLabel.then {
            $0.text = "내용"
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.textColor = .black
            $0.sizeToFit()
        }
        _ = contentTextView.then {
            $0.text = chapterListData?.content
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
            $0.isScrollEnabled = false
            $0.isEditable = false
            $0.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5) // 기본 설정 값인 0이 좌우 여백이 있기 때문에 조정 필요
            $0.allowsEditingTextAttributes = true
            $0.isSelectable = false
        }
        
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
            make.centerY.equalTo(placeTagLabel)
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
    
    @objc func didTapCheckButton(_ sender: UIButton) {
        let checkVC = CheckVC()
        checkVC.modalPresentationStyle = .automatic
        
        checkVC.studyUserList = studyUserList
        
        studyDetailVC?.navigationController?.pushViewController(checkVC, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapDismissButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.presentingViewController?.view.alpha = 1.0
        }
        dismiss(animated: true, completion: nil)
    }
    
}
