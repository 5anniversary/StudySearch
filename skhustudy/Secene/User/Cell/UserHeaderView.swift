//
//  UserHeaderView.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/05.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then

class UserHeaderView: UITableViewHeaderFooterView {

//MARK: - UI components

    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var interestSubjectTextView: UITextView!
    
    @IBOutlet var introduceMeTextView: UITextView!
    
    @IBOutlet var doingStudyButton: UIButton!
    @IBOutlet var finishStudyButton: UIButton!
    
//MARK: - Variables and Properties


//MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Helper
    
    func initUserInfo() {
        
        nicknameLabel.then {
            $0.text = "nickname"
            $0.font = Font.titleLabel
            $0.sizeToFit()
            $0.textAlignment = .center
        }
        interestSubjectTextView.then {
            $0.text = "#swift #iOS #Xcode"
            $0.font = Font.contentTextView
            $0.textAlignment = .natural
        }
        introduceMeTextView.then {
            $0.text = "Yo- introduce myself.\nThis is competition"
            $0.font = UIFont.systemFont(ofSize: 17)
            $0.textAlignment = .natural
        }
        
        doingStudyButton.then {
            $0.tintColor = .white
            $0.setTitle("참여 중인 스터디", for: .normal)
            $0.backgroundColor = .signatureColor
        }
        finishStudyButton.then {
            $0.tintColor = .signatureColor
            $0.setTitle("참여 한 스터디", for: .normal)
            $0.backgroundColor = .white
        }
    }
    
}
