//
//  CheckVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

import Then
import SnapKit

class CheckVC: UIViewController {
    
    // MARK: - UI components
    
    let checkTV = UITableView()
    
    // MARK: - Variables and Properties
    
    var studyUserList: [StudyUser]?
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "체크 하기"
        
        setTableView()
    }
    
    func setTableView(){
        
        checkTV.delegate = self
        checkTV.dataSource = self

        checkTV.register(CheckTVC.self, forCellReuseIdentifier: "CheckTVC")
        
        view.addSubview(checkTV)
        
        checkTV.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableView Delegate

extension CheckVC: UITableViewDelegate {}
extension CheckVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckTVC", for: indexPath) as! CheckTVC
        
        cell.selectionStyle = .none
        
        cell.studyUser = studyUserList?[indexPath.row]
        
        cell.initCell()
        cell.addContentView()
        cell.updateButtonStatus()
        
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
