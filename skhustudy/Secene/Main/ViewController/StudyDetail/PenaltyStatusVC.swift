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

import SwiftKeychainWrapper

class PenaltyStatusVC: UIViewController {
    
    // MARK: - UI components
    
    let penaltyTV = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }
    
    // MARK: - Variables and Properties
    
    var studyID: Int?
    var studyPenaltyInfo: Fine?
    var userPenaltyStatusList: UserPenaltyStatusList?
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "벌금 현황"
        
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getStudyPenaltyInfoService(studyID: studyID ?? 0, completionHandler: {(returnedData)-> Void in
            self.penaltyTV.reloadData()
            
        })
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
        
        headerView?.studyPenaltyInfo = studyPenaltyInfo
        
        headerView?.initHeaderView()
        headerView?.addContentView()

        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PenaltyStatusTVC", for: indexPath) as! PenaltyStatusTVC
        
        cell.selectionStyle = .none
        
        cell.studyPenaltyInfo = studyPenaltyInfo
        cell.userPenaltyStatusInfo = userPenaltyStatusList?.data[indexPath.row]
        
        cell.initCell()
        cell.addContentView()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPenaltyStatusList?.data.count ?? 0
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

// MARK: - 스터디 참여자 벌금 현황 정보 Service

extension PenaltyStatusVC {
    
    func getStudyPenaltyInfoService(studyID: Int, completionHandler: @escaping (_ returnedData: UserPenaltyStatusList) -> Void) {
        let token = KeychainWrapper.standard.string(forKey: "token") ?? ""
        
        StudyService.shared.getStudyPenaltyInfo(token: token, studyID: studyID) { result in
        
            switch result {
                case .success(let res):
                    let responseUserPenaltyStatusList = res as! UserPenaltyStatusList
                    
                    switch responseUserPenaltyStatusList.status {
                    case 200:
                        self.userPenaltyStatusList = responseUserPenaltyStatusList
                        
                        completionHandler(self.userPenaltyStatusList!)
                        
                    case 400, 406, 411, 500, 420, 421, 422, 423:
                        let alert = UIAlertController(title: responseUserPenaltyStatusList.message, message: "", preferredStyle: .alert)
                        let comfirmAction = UIAlertAction(title: "확인", style: .cancel) { action in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alert.addAction(comfirmAction)

                        self.present(alert, animated: true)
                        
                    default:
                        let alert = UIAlertController(title: "오류가 발생하였습니다", message: "", preferredStyle: .alert)
                        let comfirmAction = UIAlertAction(title: "확인", style: .cancel) { action in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alert.addAction(comfirmAction)

                        self.present(alert, animated: true)
                    }
                case .requestErr(_):
                    print(".requestErr")
                case .pathErr:
                    print(".pathErr")
                case .serverErr:
                    print(".serverErr")
                case .networkFail:
                    print(".networkFail")
            }
        }
    }
    
}
