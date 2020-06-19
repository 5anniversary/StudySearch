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

import SwiftKeychainWrapper

class RegisterMemberTVC: UITableViewCell {
    
    // MARK: - UI components
    
    let wantUserImageView = UIImageView()
    
    let wantUserNameLabel = UILabel()
    
    let registerButton = UIButton()

    // MARK: - Variables and Properties
    
    var registerMemberVC: UIViewController?
    
    var studyID = 0
    var wantUser: StudyUser?
    var indexPathNum: Int?
    
    var isAlreadyRegitser = false
    
    // MARK: - Life Cycle
    
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
            if isAlreadyRegitser == false {
                $0.setTitle("스터디원 추가", for: .normal)
            }
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            $0.makeRounded(cornerRadius: 15)
            $0.tintColor = .white
            $0.backgroundColor = .signatureColor
            $0.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        }
    }
    
    @objc func didTapRegisterButton() {
        registerStudyUserService()
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

// MARK: - 스터디 참여신청자 승인 서버 연결

extension RegisterMemberTVC {
    
    func registerStudyUserService() {
        
        guard (studyID != 0) else {
            registerMemberVC?.simpleAlert(title: "❗️사용자 등록 실패❗️", message: "studyID가 없습니다")
            return
        }
        guard (indexPathNum != nil) else {
            registerMemberVC?.simpleAlert(title: "❗️사용자 등록 실패❗️", message: "indexPath error")
            return
        }
        
        var addStudyUserInfo = StudyUser(id: 0, userID: "", name: "", image: "")
        addStudyUserInfo.id = wantUser?.id ?? 0
        addStudyUserInfo.name = wantUser?.name ?? ""
        addStudyUserInfo.userID = wantUser?.userID ?? ""
        addStudyUserInfo.image = wantUser?.image ?? ""
        
        let token = KeychainWrapper.standard.string(forKey: "token") ?? ""
        StudyService.shared.addStudyUser(token: token, id: studyID, deleteUserIndex: indexPathNum ?? 0, studyUser: [addStudyUserInfo]) { result in
            
            switch result {
            case .success(let res):
                let responseAddStudyUser = res as! Response
                
                switch responseAddStudyUser.status {
                case 200:
                    _ = self.registerButton.then {
                        $0.setTitle("추가 완료", for: .normal)
                        self.isAlreadyRegitser = true
                        $0.isEnabled = false
                        $0.alpha = 0.5
                    }
                    
                case 400, 406, 411, 500, 420, 421, 422, 423:
                    self.registerMemberVC?.simpleAlert(title: responseAddStudyUser.message, message: "")
                    
                default:
                    self.registerMemberVC?.simpleAlert(title: "오류가 발생하였습니다", message: "")
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
