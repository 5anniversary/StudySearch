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
        self.view.addSubview(userTableView)
        
        userTableView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        userTableView.register(UINib(nibName: "StudyTVC", bundle: nil), forCellReuseIdentifier: "StudyTVC")
    }
}

    // MARK: - TableView

extension UserVC: UITableViewDelegate { }
extension UserVC: UITableViewDataSource {

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
            $0.textAlignment = .natural
        }
        
        let introduceMeTextView = UITextView().then {
            $0.text = "Yo- introduce myself.\nThis is competition"
            $0.font = Font.contentTextView
            $0.textAlignment = .natural
        }
        
        let doingStudyButton = UIButton().then {
            $0.layer.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            $0.tintColor = .black
            $0.setTitle("참여 중인 스터디", for: .normal)
            $0.backgroundColor = .gray
        }
        let finishStudyButton = UIButton().then {
            $0.layer.frame = CGRect(x: 0, y: 0, width: doingStudyButton.frame.size.width, height: doingStudyButton.frame.size.height)
            $0.tintColor = .black
            $0.setTitle("참여 한 스터디", for: .normal)
            $0.backgroundColor = .lightGray
        }
        
        self.headerView.addSubview(userImage)
        self.headerView.addSubview(nicknameLabel)
        self.headerView.addSubview(interestSubjectTextView)
        
        self.headerView.addSubview(introduceMeTextView)
        
        self.headerView.addSubview(doingStudyButton)
        self.headerView.addSubview(finishStudyButton)
        
        userImage.snp.makeConstraints{ (make) in
            make.top.equalTo(headerView).offset(20)
            make.left.equalTo(headerView).offset(30)
            make.height.equalTo(100)
            make.width.equalTo(userImage.snp.height)
        }
        nicknameLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(userImage.snp.top)
            make.left.equalTo(userImage.snp.right).offset(20)
            make.right.equalTo(headerView).offset(-30)
        }
        interestSubjectTextView.snp.makeConstraints{ (make) in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.left.equalTo(nicknameLabel.snp.left)
            make.right.equalTo(nicknameLabel.snp.right)
            make.height.equalTo(30)
        }
        
        introduceMeTextView.snp.makeConstraints{ (make) in
            make.top.equalTo(userImage.snp.bottom).offset(10)
            make.left.equalTo(userImage.snp.left)
            make.right.equalTo(nicknameLabel.snp.right)
            make.height.equalTo(80)
        }
        
        doingStudyButton.snp.makeConstraints{ (make) in
            make.top.equalTo(introduceMeTextView.snp.bottom).offset(10)
            make.left.equalTo(headerView)
            make.bottom.equalTo(headerView)
        }
        finishStudyButton.snp.makeConstraints{ (make) in
            make.top.equalTo(introduceMeTextView.snp.bottom).offset(10)
            make.left.equalTo(doingStudyButton.snp.right)
            make.right.equalTo(headerView)
            make.bottom.equalTo(headerView)
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTVC", for: indexPath) as! StudyTVC
        
        cell.selectionStyle = .none
        cell.initCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let weekDetailSB = UIStoryboard(name: "WeekDetail", bundle: nil)
        let showWeekDetailVC = weekDetailSB.instantiateViewController(withIdentifier: "WeekDetail") as! WeekDetailVC
        
        self.navigationController?.pushViewController(showWeekDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
