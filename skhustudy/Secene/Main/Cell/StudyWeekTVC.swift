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
    
    @IBOutlet var weeksLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var subjectLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helper
    
    func initCell () {
        weeksLabel.then {
            $0.text = "1주차"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        locationLabel.then {
            $0.text = "강남역 6번출구 할리스 카페"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        subjectLabel.then {
            $0.text = "xcode 설치 및 명칭 알아보기"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        
        dateLabel.then {
            $0.text = "2020-05-02 오후 1시"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
    }
    
}
