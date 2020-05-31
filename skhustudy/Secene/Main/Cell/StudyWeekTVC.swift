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
    
    var studyChapterInfo: ChapterListData?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helper
    
    func initCell () {
        weeksLabel.then {
            $0.text = String(studyChapterInfo?.id ?? 0) + "주차"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        locationLabel.then {
            $0.text = studyChapterInfo?.place
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        subjectLabel.then {
            $0.text = studyChapterInfo?.content
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        
        dateLabel.then {
            $0.text = studyChapterInfo?.date
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
    }
    
}
