//
//  AddUserInfoVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then

class AddUserInfoVC: UIViewController {
    
    // TODO: Gesture 추가
    let profileImageView = UIImageView().then {
        $0.backgroundColor = UIColor.gray
        $0.setRounded(radius: nil)
    }
    
    let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력하세요"
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: UIColor.signatureColor, thickness: 1)
    }
    
    let ageTextField = UITextField().then {
        $0.placeholder = "나이를 입력하세요"
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.keyboardType = .numberPad
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1)
    }
    // 성별
    let maleButton = UIButton().then {
        $0.setTitle("남자", for: .normal)
        $0.addTarget(self, action: #selector(didTapMaleButton), for: .touchUpInside)
    }
    
    let femaleButton = UIButton().then {
        $0.setTitle("여자", for: .normal)
        $0.addTarget(self, action: #selector(didTapFemaleButton), for: .touchUpInside)
    }
    
    // 자기소개
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        addSubView()
    }
    
    @objc func didTapMaleButton(){
        femaleButton.isSelected = false
        maleButton.isSelected = true
    }
    
    @objc func didTapFemaleButton(){
        maleButton.isSelected = false
        femaleButton.isSelected = true
        
    }
}

extension AddUserInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
