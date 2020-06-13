//
//  UserVC+Constraints.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/06/11.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper

extension UserVC {
    
    func set() {
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(chatButton)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(ageLabel)
        self.contentView.addSubview(sexLabel)
        self.contentView.addSubview(categoryLabel)
        self.contentView.addSubview(locationLabel)
        self.contentView.addSubview(pinImageView)
        self.contentView.addSubview(contentTextView)
        self.contentView.addSubview(tabCV)
        self.contentView.addSubview(pageCV)
        self.contentView.addSubview(highlightView)
        
        highlightView.backgroundColor = .signatureColor
        
        tabCV.delegate = self
        tabCV.dataSource = self
        pageCV.delegate = self
        pageCV.dataSource = self
        scrollView.delegate = self
        scrollView.bounces = false
        
        
        contentTextView.isUserInteractionEnabled = false
        
//        let tabHeight: CGFloat = self.tabBarController?.tabBar.frame.height ?? 0
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView)
            make.top.equalTo(scrollView)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        tabCV.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(194)
            make.leading.equalTo(scrollView)
            make.trailing.equalTo(scrollView)
            make.height.equalTo(44)
        }
        
        pageCV.snp.makeConstraints { (make) in
            make.top.equalTo(tabCV.snp.bottom)
            make.leading.equalTo(scrollView)
            make.trailing.equalTo(scrollView)
            make.height.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(15)
            make.leading.equalTo(contentView).offset(20)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        chatButton.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(36)
            make.leading.equalTo(contentView).offset(20)
            make.width.equalTo(imageView)
            make.height.equalTo(32)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(15)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.height.equalTo(25)
        }

        ageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.height.equalTo(13)
        }

        sexLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.leading.equalTo(ageLabel.snp.trailing).offset(12)
            make.height.equalTo(13)
        }

        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ageLabel.snp.bottom).offset(15)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.height.equalTo(13)
        }

        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
            make.height.equalTo(13)
        }

        pinImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.trailing.equalTo(locationLabel.snp.leading)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }

        contentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(9)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.width.equalTo(self.view.frame.width * 0.63)
            make.height.equalTo(72)
        }
        
        highlightView.snp.makeConstraints { (make) in
            make.top.equalTo(tabCV.snp.bottom).offset(-3)
            make.width.equalTo(self.contentView.frame.width / 2)
            make.height.equalTo(3)
        }
        
        imageView.setRounded(radius: 45)
        chatButton.backgroundColor = .signatureColor
        chatButton.setRounded(radius: 13)
        if userID == KeychainWrapper.standard.string(forKey: "userID"){
            chatButton.setTitle("프로필 설정", for: .normal)
        } else {
            chatButton.setTitle("채팅하기", for: .normal)
        }
        chatButton.setTitleColor(.white, for: .normal)
        chatButton.titleLabel?.font = Font.lightLabel
        nameLabel.font = Font.titleLabel
        ageLabel.font = Font.lightLabel
        sexLabel.font = Font.lightLabel
        categoryLabel.font = Font.lightLabel
        categoryLabel.textColor = .signatureColor
        contentTextView.font = Font.lightLabel
        locationLabel.font = Font.lightLabel
        pinImageView.image = UIImage(named: "pin-map-icon")
        
    }
    
    func setInfo() {
        imageView.imageFromUrl(userInfo?.image,
                               defaultImgPath: "https://t1.daumcdn.net/cfile/tistory/2513B53E55DB206927")
        nameLabel.text = userInfo?.nickName
        ageLabel.text = "나이 " + String(describing: userInfo?.age ?? 0)
        sexLabel.text = userInfo?.sex == 0 ? "남자" : "여자"
        locationLabel.text = userInfo?.location
        guard let content = userInfo?.content else { return }
        contentTextView.text = content
        
        var category = ""
        
        for i in 0..<3 {
            category.append(contentsOf: "#")
            category.append(contentsOf: (userInfo?.userCategory[i] ?? ""))
            category.append(contentsOf: " ")
        }
        categoryLabel.text = category
        
        
    }
}
