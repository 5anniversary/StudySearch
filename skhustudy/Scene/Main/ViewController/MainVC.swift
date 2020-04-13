//
//  MainVC.swift
//  skhustudy
//
//  Created by Junhyeon on 2020/04/09.
//  Copyright © 2020 skhuStudy. All rights reserved.
//

import UIKit

import SnapKit
import Then

class MainVC: UIViewController {

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UI components
    
    let statusLabel = UILabel().then {
        $0.text = "여기는 메인화면"
    }
    
    // MARK: - Variables and Properties
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
    }
    
    // MARK: - Helper
    
    func addSubView() {
        self.view.addSubview(statusLabel)
        
        statusLabel.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }

    }
}
