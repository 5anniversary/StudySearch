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
    
    var studyID = 0
    
    weak var studyDetailVC: UIViewController?
    
//MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initStudyDetail()
    }
    
    
    //MARK: - Helper
    
    @IBAction func createStudy(_ sender: Any) {
        
        let CreateWeekSB = UIStoryboard(name: "CreateWeek", bundle: nil)
        let showCreateWeekVC = CreateWeekSB.instantiateViewController(withIdentifier: "CreateWeekVC") as! CreateWeekVC
        
        showCreateWeekVC.studyID = studyID
        
        studyDetailVC?.navigationController?.pushViewController(showCreateWeekVC, animated: true)
    }
    
    func initStudyDetail() {
        
        joinButton.then {
            $0.backgroundColor = .signatureColor
            $0.setTitle("생성하기", for: .normal)
        }
        
    }
    
}

