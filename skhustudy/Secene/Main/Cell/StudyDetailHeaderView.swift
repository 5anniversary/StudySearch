//
//  StudyDetailHeaderView.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/04/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper

class StudyDetailHeaderView: UITableViewHeaderFooterView {

//MARK: - UI components
    
    @IBOutlet var studyImageView: UIImageView!
    
    @IBOutlet var studyTitleLabel: UILabel!
    @IBOutlet var studyCategoryLabel: UILabel!
    @IBOutlet var studyInfoLabel: UILabel!
    @IBOutlet var isPenalty: UILabel!
    
    @IBOutlet var joinButton: UIButton!
    
    @IBOutlet var studyExplainTextView: UITextView!

//MARK: - Variables and Properties

    var studyDetailVC: UIViewController?
    
    var studyDetailInfo: StudyInfo?
    var studyID = 0

//MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        getStudyDetailInfoService(completionHandler: {(returnedData)-> Void in
            
            if(self.studyDetailInfo?.data.count != 0){
                self.initStudyDetail()
            }
        })
    }
    
    
    //MARK: - Helper
    
    func initStudyDetail() {
        
        studyTitleLabel.then {
            $0.text = studyDetailInfo?.data[0].name
            $0.font = Font.studyTitleLabel
            $0.sizeToFit()
        }
        studyCategoryLabel.then {
            $0.text = studyDetailInfo?.data[0].category
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        studyInfoLabel.then {
            let location = studyDetailInfo?.data[0].location ?? "장소"
            let people = String(studyDetailInfo?.data[0].userLimit ?? 0) + "명"
            $0.text =  location + " / " + people
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        isPenalty.then {
            let isPenalty = studyDetailInfo?.data[0].isFine ?? false == true
            var penaltyStr = ""
            if (isPenalty == true) {
                penaltyStr = "있음"
            } else {
                penaltyStr = "없음"
            }
            $0.text = "벌금제도 " + penaltyStr
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        
        joinButton.then {
            $0.backgroundColor = .signatureColor
        }
        
        studyExplainTextView.then {
            $0.text = studyDetailInfo?.data[0].content
            $0.font = Font.studyContentsLabel
            $0.isScrollEnabled = false
            $0.sizeToFit()
        }
        
    }
    
}

// MARK: - StudyDetailInfo Service

extension StudyDetailHeaderView {
    
    func getStudyDetailInfoService(completionHandler: @escaping (_ returnedData: StudyInfo) -> Void) {
        let token = KeychainWrapper.standard.string(forKey: "token") ?? ""
        StudyService.shared.getStudyDetailInfo(token: token, id: studyID) { result in
        
            switch result {
                case .success(let res):
                    let responseStudyInfo = res as! StudyInfo
                    
                    switch responseStudyInfo.status {
                    case 200:
                        self.studyDetailInfo = responseStudyInfo

                        completionHandler(self.studyDetailInfo!)
                        
                    case 400, 406, 411, 500, 420, 421, 422, 423:
                        let presentVC = self.studyDetailVC?.presentingViewController
                        self.studyDetailVC?.dismiss(animated: true, completion: {
                            presentVC?.simpleAlert(title: responseStudyInfo.message, message: "")
                        })
                        
                    default:
                        let presentVC = self.studyDetailVC?.presentingViewController
                        self.studyDetailVC?.dismiss(animated: true, completion: {
                            presentVC?.simpleAlert(title: "오류가 발생하였습니다", message: "")
                        })
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
