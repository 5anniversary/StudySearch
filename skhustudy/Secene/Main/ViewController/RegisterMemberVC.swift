//
//  RegisterMemberVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/13.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

import Then
import SnapKit

class RegisterMemberVC: UIViewController {
    
    // MARK: - UI components
    
    let registerMemberTV = UITableView()
    
    // MARK: - Variables and Properties
    
    var wantUserList: [StudyUser]?
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "신청"
        
        setTableView()
    }
    
    func setTableView(){
        
        registerMemberTV.delegate = self
        registerMemberTV.dataSource = self

        registerMemberTV.register(RegisterMemberTVC.self, forCellReuseIdentifier: "RegisterMemberTVC")
        
        view.addSubview(registerMemberTV)
        
        registerMemberTV.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableView Delegate

extension RegisterMemberVC: UITableViewDelegate {}
extension RegisterMemberVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterMemberTVC", for: indexPath) as! RegisterMemberTVC
        
        cell.selectionStyle = .none
        
        cell.wantUser = wantUserList?[indexPath.row]
        
        cell.initCell()
        cell.addContentView()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let wantUserNum = wantUserList?.count ?? 0
        
        if wantUserNum == 0 {
            registerMemberTV.setEmptyView(title: "신청자가 없습니다❗️", message: "")
        }
        
        return wantUserNum
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
