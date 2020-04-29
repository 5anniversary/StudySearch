//
//  StudyDetail.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/04/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then
import SnapKit

class StudyDetailVC: UIViewController {
    
    // MARK: - UI components
    
    @IBOutlet var studyImageView: UIImageView!
    
    @IBOutlet var studyTitleLabel: UILabel!
    @IBOutlet var studyCategoryLabel: UILabel!
    @IBOutlet var studyInfoLabel: UILabel!
    @IBOutlet var isPenalty: UILabel!
    
    @IBOutlet var studyExplainTextView: UITextView!
    
    // MARK: - Variables and Properties
    
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initStudyDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
 
    
    // MARK: - Helper
    
    func initStudyDetail() {
        
        studyTitleLabel.then {
            $0.text = "팀쿡과 함께하는 스위프트 기초"
            $0.font = Font.studyTitleLabel
            $0.sizeToFit()
        }
        studyCategoryLabel.then {
            $0.text = "#iOS #Swift"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        studyInfoLabel.then {
            $0.text = "산호세, CA / 5명"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        isPenalty.then {
            $0.text = "벌금제도 있음"
            $0.font = Font.studyContentsLabel
            $0.sizeToFit()
        }
        
        studyExplainTextView.then {
            $0.text = "이 스터디는 영국으로 부터 시작되어... 미국 실리콘벨리 인근 마을에서 이뤄지는 스터디 모임입니다. 누구도 만나 볼 수 없는 명 강사 팀쿡과 함께 스위프트에 대해 1달 동안 같이 공부를 할 예정입니다."
        }
        
    }
}
