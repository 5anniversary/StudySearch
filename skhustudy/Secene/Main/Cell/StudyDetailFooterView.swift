//
//  StudyDetailFooterView.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/03.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class StudyDetailFooterView: UITableViewHeaderFooterView {

//MARK: - UI components

    @IBOutlet var joinButton: UIButton!

//MARK: - Variables and Properties
    
//MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initStudyDetail()
    }
    
    
    //MARK: - Helper
    
    func initStudyDetail() {
        
        joinButton.then {
            $0.backgroundColor = .signatureColor
            $0.setTitle("생성하기", for: .normal)
        }
        
    }
    
}

