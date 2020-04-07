//
//  ViewController.swift
//  StudySearch
//
//  Created by Junhyeon on 2020/03/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then
import SnapKit


final class ViewController: UIViewController {

    // MARK: - UI components
    
    let label = UILabel().then {
        $0.text = "Then 사용법"
        $0.textAlignment = .center
        $0.font = Font.nameLabel
        $0.textColor = .black
        $0.frame = CGRect.init(x: 200, y: 200, width: 100, height: 100)
        $0.sizeToFit()
    }
    
    // MARK: - Variables and Properties

    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
    }

    // MARK: - Helper
    
    // example 함수 역할 : example임을 보여줌
    func example() {
        print("example")
    }
    
}

// MARK: - extension에 따라 적당한 명칭 작성
