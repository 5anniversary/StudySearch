//
//  MemberListVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/13.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

import Then
import SnapKit

class MemberListVC: UIViewController {
    
    // MARK: - UI components
    
    let memberListTV = UITableView()
    
    // MARK: - Variables and Properties
    
    var studyUserList: [StudyUser]?
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    func setTableView(){
        
        memberListTV.delegate = self
        memberListTV.dataSource = self

        memberListTV.register(MemberListTVC.self, forCellReuseIdentifier: "MemberListTVC")
        
        view.addSubview(memberListTV)
        
        memberListTV.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableView Delegate

extension MemberListVC: UITableViewDelegate {}
extension MemberListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberListTVC", for: indexPath) as! MemberListTVC
        
        cell.selectionStyle = .none
        
        cell.studyUser = studyUserList?[indexPath.row]
        
        cell.initCell()
        cell.addContentView()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyUserList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}
