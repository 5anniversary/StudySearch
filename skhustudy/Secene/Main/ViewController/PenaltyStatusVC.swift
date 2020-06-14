//
//  PenaltyStatusVC.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

import Then
import SnapKit

class PenaltyStatusVC: UIViewController {
    
    // MARK: - UI components
    
    let penaltyTV = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }
    
    // MARK: - Variables and Properties
    
    var studyUserList: [StudyUser]?
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "벌금 현황"
        
        setTableView()
    }
    
    func setTableView(){
        
        penaltyTV.delegate = self
        penaltyTV.dataSource = self

        penaltyTV.register(PenaltyStatusHeaderView.self, forHeaderFooterViewReuseIdentifier: "PenaltyStatusHeaderView")
        penaltyTV.register(PenaltyStatusTVC.self, forCellReuseIdentifier: "PenaltyStatusTVC")
        
        view.addSubview(penaltyTV)
        
        penaltyTV.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableView Delegate

extension PenaltyStatusVC: UITableViewDelegate {}
extension PenaltyStatusVC: UITableViewDataSource {
    
    // Table HeaderView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PenaltyStatusHeaderView") as? PenaltyStatusHeaderView
        
        headerView?.initHeaderView()
        headerView?.addContentView()

        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PenaltyStatusTVC", for: indexPath) as! PenaltyStatusTVC
        
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
