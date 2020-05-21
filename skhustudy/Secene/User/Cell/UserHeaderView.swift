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

    var userInfo: User?

//MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Helper
    
    func initUserInfo() {
        
        getUserInfoService(completionHandler: {(returnedData) -> Void in
            
            self.userImageView.then {
                if self.userInfo?.data.image != "" || self.userInfo?.data.image != nil {
                    $0.imageFromUrl(self.userInfo?.data.image, defaultImgPath: "")
                }
                $0.contentMode = .scaleToFill
                $0.setRounded(radius: nil)
            }
            self.nicknameLabel.then {
                $0.text = self.userInfo?.data.nickName
                $0.font = Font.titleLabel
                $0.sizeToFit()
                $0.textAlignment = .center
            }
            self.interestSubjectTextView.then {
                var categoryStr = ""
                for category in self.userInfo?.data.userCategory ?? [] {
                    categoryStr += "#" + category + " "
                }
                $0.text = categoryStr
                $0.font = Font.contentTextView
                $0.textAlignment = .natural
                $0.isEditable = false
                $0.isSelectable = false
            }
            self.introduceMeTextView.then {
                $0.text = self.userInfo?.data.content
                $0.font = UIFont.systemFont(ofSize: 17)
                $0.textAlignment = .natural
                $0.isEditable = false
                $0.isSelectable = false
                $0.translatesAutoresizingMaskIntoConstraints = true
                $0.sizeToFit()
                $0.isScrollEnabled = false
            }
            
            self.doingStudyButton.then {
                $0.tintColor = .white
                $0.setTitle("참여 중인 스터디", for: .normal)
                $0.backgroundColor = .signatureColor
            }
            self.finishStudyButton.then {
                $0.tintColor = .signatureColor
                $0.setTitle("참여 한 스터디", for: .normal)
                $0.backgroundColor = .white
            }
        })
        
    }
    
}

extension UserHeaderView {
    
    func getUserInfoService(completionHandler: @escaping (_ returnedData: User) -> Void ) {
        UserService.shared.getUserInfo() { result in
        
            switch result {
                case .success(let res):
                    self.userInfo = res as? User
                    completionHandler(self.userInfo!)
                
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

//extension UserHeaderView: UITextViewDelegate {
//
//    // TextView의 동적인 크기 변화를 위한 function
//    func textViewDidChange(_ textView: UITextView) {
//        let size = CGSize(width: view.frame.width, height: .infinity)
//        let estimatedSize = textView.sizeThatFits(size)
//        textView.constraints.forEach { (constraint) in
//            if constraint.firstAttribute == .height {
//                constraint.constant = estimatedSize.height
//            }
//        }
//    }
//
//}
