//
//  UserVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SnapKit
import Then

class UserVC: UIViewController {
    
    // MARK: - UI components
    
    // 프로필 화면
    let userTableView = UITableView()
    let headerView = UIView()
    
    // MARK: - Variables and Properties
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTableView.dataSource = self
        self.userTableView.delegate = self
        
        addUserTableView()
    }
    
    // MARK: - Helper
    
    func addUserTableView () {
        self.userTableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        
        self.view.addSubview(userTableView)
        
        userTableView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

    // MARK: - TableView

extension UserVC: UITableViewDelegate { }
extension UserVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        cell.initCell()
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let userImage = UIImageView().then {
            $0.layer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            $0.setRounded(radius: nil)
            $0.image = #imageLiteral(resourceName: "testUserImage")
        }
        let nicknameLabel = UILabel().then {
            $0.text = "nickname"
            $0.font = Font.titleLabel
            $0.sizeToFit()
            $0.textAlignment = .center
        }
        let interestSubjectTextView = UITextView().then {
            $0.text = "#swift #iOS #Xcode"
            $0.font = Font.contentTextView
            $0.sizeToFit()
        }
        
        let introduceMeTextView = UITextView().then {
            $0.text = "Yo- introduce myself.\n This is competition"
            $0.font = Font.contentTextView
            $0.sizeToFit()
            $0.textAlignment = .natural
        }
        
        self.headerView.addSubview(userImage)
        self.headerView.addSubview(nicknameLabel)
        self.headerView.addSubview(interestSubjectTextView)
//        self.headerView.addSubview(introduceMeTextView)
        
        userImage.snp.makeConstraints{ (make) in
            make.top.equalTo(headerView).offset(20)
            make.left.equalTo(headerView).offset(30)
            make.height.equalTo(100)
            make.width.equalTo(userImage.snp.height)
        }
        
        nicknameLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(userImage.snp.top)
            make.left.equalTo(userImage.snp.right).offset(10)
            make.right.equalTo(headerView).offset(30)
        }

        interestSubjectTextView.snp.makeConstraints{ (make) in
            make.centerX.equalTo(headerView)
            make.top.equalTo(headerView)
//            make.top.equalTo(nicknameLabel.snp.bottom)
//            make.left.equalTo(userImage).offset(10)
//            make.right.equalTo(headerView)
        }
//
//        introduceMeTextView.snp.makeConstraints{ (make) in
//            make.top.equalTo(nicknameLabel)
//            make.right.equalTo(headerView).offset(10)
//        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160//UITableView.automaticDimension
    }
    
}
