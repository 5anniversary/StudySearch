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

import SwiftKeychainWrapper

class CheckVC: UIViewController {
    
    // MARK: - UI components
    
    let checkTV = UITableView()
    
    // MARK: - Variables and Properties
    
    var studyID: Int?
    var chapterID: Int?
    
    var userPenaltyStatusList: ChapterPenaltyStatusList?
    var studyUserList: [StudyUser]?
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "체크 하기"
        
        setTableView()
        
        getChapterPenaltyStatusListService(completionHandler: {returnedData -> Void in
            print(self.userPenaltyStatusList)
            self.checkTV.reloadData()
        })
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
        cell.userPenaltyStatus = userPenaltyStatusList?.data[0]
        
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

// MARK: - 스터디 참여자 벌금 현황 정보 Service

extension CheckVC {
    
    func getChapterPenaltyStatusListService(completionHandler: @escaping (_ returnedData: ChapterPenaltyStatusList) -> Void) {
        let token = KeychainWrapper.standard.string(forKey: "token") ?? ""
        
        StudyService.shared.getChapterPenaltyStatus(token: token, studyID: studyID ?? 0, chapterID: chapterID ?? 0) { result in
        
            switch result {
                case .success(let res):
                    let responseUserPenaltyStatusList = res as! ChapterPenaltyStatusList
                    
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
