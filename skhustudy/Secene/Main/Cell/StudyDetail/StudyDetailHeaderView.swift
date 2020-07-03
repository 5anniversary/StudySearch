//
//  StudyDetailHeaderView.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/04/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SnapKit
import Then

import SwiftKeychainWrapper

class StudyDetailHeaderView: UITableViewHeaderFooterView {

//MARK: - UI components
    
    let studyImageView = UIImageView()
    
    let studyTitleLabel = UILabel()
    
    let studyExplainTextView = UITextView()
    
    let placeButton = UIButton()
    let placeImageView = UIImageView()
    
    let joinButton = UIButton()
    let memberButton = UIButton()
    
    let termTextView = UITextView()
    let isPenaltyButton = UIButton()

//MARK: - Variables and Properties

    var studyDetailVC: UIViewController?
    
    var studyDetailInfo: StudyInfo?
    
    var isChiefUser = false
    var isWantUser = false

//MARK: - Life Cycle
    
    //MARK: - Helper

    func initStudyDetail() {
        
        _ = studyImageView.then {
            $0.image = UIImage(named: "default_study_image")
            $0.contentMode = .scaleAspectFill
            $0.setRounded(radius: 45)
        }
        
        _ = studyTitleLabel.then {
            $0.text = studyDetailInfo?.data[0].name
            $0.font = Font.studyTitleLabel
            $0.sizeToFit()
        }
        
        _ = placeButton.then {
            $0.setTitle(studyDetailInfo?.data[0].location, for: .normal)
            $0.titleLabel?.font = Font.studyContentsLabel
            $0.setTitleColor(UIColor(red: 72, green: 72, blue: 72), for: .normal)
            $0.titleLabel?.textAlignment = .right

            $0.isUserInteractionEnabled = false
        }
        _ = placeImageView.then {
            $0.image = UIImage(named: "place_icon")?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = UIColor(red: 72, green: 72, blue: 72)
        }
        
        _ = studyExplainTextView.then {
            $0.text = studyDetailInfo?.data[0].content
            $0.font = Font.studyContentsLabel
            $0.isUserInteractionEnabled = false
            $0.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5) // 기본 설정 값인 0이 좌우 여백이 있기 때문에 조정 필요
            $0.isScrollEnabled = false
        }
        
        _ = joinButton.then {
            if isChiefUser == true {
                $0.setTitle("참여 신청 확인", for: .normal)
                $0.isEnabled = true
                $0.addTarget(self, action: #selector(didTapCheckRegisterButton), for: .touchUpInside)
            } else if isWantUser == true {
                $0.setTitle("참여 신청 완료", for: .normal)
                $0.isEnabled = false
            } else {
                $0.setTitle("참여하기", for: .normal)
                $0.isEnabled = true
                $0.addTarget(self, action: #selector(didTapjoinButton), for: .touchUpInside)
            }
            
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            $0.makeRounded(cornerRadius: 10)
            $0.tintColor = .white
            $0.backgroundColor = .signatureColor
        }
        _ = memberButton.then {
            $0.contentHorizontalAlignment = .left
            
            $0.setImage(UIImage(systemName: "person"), for: .normal)
            $0.tintColor = .black
            
            let userLimitStr = String(studyDetailInfo?.data[0].userLimit ?? 0)
            let userJoinStr = String(studyDetailInfo?.data[0].studyUser.count ?? 0)
            let userStatusStr = userJoinStr + " / " + userLimitStr
            $0.setTitle(userStatusStr, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            $0.setTitleColor(.black, for: .normal)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            $0.addTarget(self, action: #selector(didTapMemberButton), for: .touchUpInside)
        }
        _ = termTextView.then {
            let isDate = studyDetailInfo?.data[0].isDate ?? false == true
            var termStr = "모집기간"
            if (isDate == true) {
                termStr += "\n"
                let startDate = studyDetailInfo?.data[0].startDate ?? "0000.00.00"
                let endDate = studyDetailInfo?.data[0].endDate ?? "0000.00.00"
                termStr += startDate + " ~ " + endDate
                
            } else {
                termStr += " 없음"
            }
            $0.text = termStr
            
            $0.textAlignment = .center
            $0.centerVertically()
            $0.font = UIFont.systemFont(ofSize: 11)
            
            $0.isUserInteractionEnabled = false
            $0.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5) // 기본 설정 값인 0이 좌우 여백이 있기 때문에 조정 필요
            $0.isScrollEnabled = false
        }
        _ = isPenaltyButton.then {
            let isPenalty = studyDetailInfo?.data[0].isFine ?? false
            if (isPenalty == true) {
                isPenaltyButton.isHidden = false
            } else {
                isPenaltyButton.isHidden = true
            }
            
            $0.setTitle("벌금", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            $0.setTitleColor(.black, for: .normal)
            $0.sizeToFit()
            
            $0.addTarget(self, action: #selector(didTapIsPenaltyButton), for: .touchUpInside)
        }
        
    }
    
    @objc func didTapCheckRegisterButton() {
        let registerMemberVC = RegisterMemberVC()
        
        registerMemberVC.studyID = studyDetailInfo?.data[0].id
        registerMemberVC.wantUserList = studyDetailInfo?.data[0].wantUser
        
        studyDetailVC?.navigationController?.pushViewController(registerMemberVC, animated: true)
    }
    
    @objc func didTapjoinButton() {
        addWantUserService(completionHandler: {(returnedData) -> Void in
            _ = self.joinButton.then {
                $0.setTitle("참여 신청 완료", for: .normal)
                $0.isEnabled = false
            }
        })
    }
    
    @objc func didTapMemberButton() {
        let memberListVC = MemberListVC()
        
        memberListVC.studyUserList = studyDetailInfo?.data[0].studyUser
        
        studyDetailVC?.navigationController?.pushViewController(memberListVC, animated: true)
    }
    
    @objc func didTapIsPenaltyButton() {
        let penaltyStatusVC = PenaltyStatusVC()
        
        penaltyStatusVC.studyID = studyDetailInfo?.data[0].id
        penaltyStatusVC.studyPenaltyInfo = studyDetailInfo?.data[0].fine
        
        studyDetailVC?.navigationController?.pushViewController(penaltyStatusVC, animated: true)
    }
    
    func addContentView() {
        
        contentView.addSubview(studyImageView)
        contentView.addSubview(studyTitleLabel)
        
        contentView.addSubview(placeButton)
        contentView.addSubview(placeImageView)
        
        contentView.addSubview(studyExplainTextView)
        
        contentView.addSubview(joinButton)
        contentView.addSubview(memberButton)
        contentView.addSubview(termTextView)
        contentView.addSubview(isPenaltyButton)
        
        studyImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(90)
            make.height.equalTo(studyImageView.snp.width)
        }
        studyTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(studyImageView.snp.top)
            make.left.equalTo(studyImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        placeButton.snp.makeConstraints{ make in
            make.top.greaterThanOrEqualTo(studyImageView.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        placeImageView.snp.makeConstraints{ make in
            make.centerY.equalTo(placeButton)
            make.left.equalTo(studyImageView.snp.left)
            make.right.equalTo(placeButton.snp.left).offset(-5)
            make.width.equalTo(15)
            make.height.equalTo(placeImageView.snp.width)
        }
        
        studyExplainTextView.snp.makeConstraints{ make in
            make.top.equalTo(studyTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(studyTitleLabel.snp.left)
            make.right.equalTo(studyTitleLabel.snp.right)
        }
        
        joinButton.snp.makeConstraints{ make in
            make.top.equalTo(placeImageView.snp.bottom).offset(20)
            make.centerX.equalTo(studyImageView)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(20)
        }
        memberButton.snp.makeConstraints{ make in
            make.centerY.equalTo(joinButton)
            make.left.equalTo(joinButton.snp.right).offset(10)
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
        termTextView.snp.makeConstraints{ make in
            make.centerY.equalTo(joinButton)
            make.left.equalTo(memberButton.snp.right)
            make.width.equalTo(140)
            make.height.equalTo(40)
        }
        isPenaltyButton.snp.makeConstraints{ make in
            make.centerY.equalTo(joinButton)
            make.left.equalTo(termTextView.snp.right)
            make.right.equalToSuperview().inset(5)
        }
        
    }
    
}

// MARK: - 스터디 신청 서버 연결

extension StudyDetailHeaderView {

    func addWantUserService(completionHandler: @escaping (_ returnedData: Response) -> Void ) {
        let token = KeychainWrapper.standard.string(forKey: "token") ?? ""
        
        var wantUser = StudyUser(id: 0, userID: "", name: "", image: "")
        wantUser.id = KeychainWrapper.standard.integer(forKey: "id") ?? 0
        wantUser.name = KeychainWrapper.standard.string(forKey: "nickname") ?? ""
        wantUser.userID = KeychainWrapper.standard.string(forKey: "userID") ?? ""
        wantUser.image = KeychainWrapper.standard.string(forKey: "image") ?? ""

        let studyID = studyDetailInfo?.data[0].id ?? 0

        StudyService.shared.addWantUser(token: token, wantUser: [wantUser], studyID: studyID) { result in

            switch result {
                case .success(let res):
                    let responseAddWantUser = res as! Response
                    
                    switch responseAddWantUser.status {
                        case 200:
                            completionHandler(responseAddWantUser)
                        
                        case 400, 406, 411, 500, 420, 421, 422, 423:
                            self.studyDetailVC?.simpleAlert(title: responseAddWantUser.message, message: "")
                            
                        default:
                            self.studyDetailVC?.simpleAlert(title: "오류가 발생하였습니다", message: "")
                    }

                case .requestErr(_):
                    print(".requestErr")
                case .pathErr:
                    print(".pathErr")
                case .serverErr:
                    print(".serverErr")
                case .networkFail:
                    print(".networkFail")
            }

        }
    }
}
