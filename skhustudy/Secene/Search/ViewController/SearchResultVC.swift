//
//  SearchResultVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/06/09.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper

class SearchResultVC: UIViewController {
    
    let searchTV = UITableView()
    
    var searchResult = ""
    
    var responseStudyInfo: StudyList?
    var studyInfoList: [StudyListData] = []
    let token = KeychainWrapper.standard.string(forKey: "token")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStudyInfoSearchService(token ?? "", searchResult.stringByAddingPercentEncodingForFormData() ?? "")
        setTV()
    }
    
    func setTV(){
        self.view.addSubview(searchTV)
        searchTV.delegate = self
        searchTV.dataSource = self
        searchTV.register(StudyTVC.self, forCellReuseIdentifier: "StudyTVC")
        searchTV.separatorStyle = .none
        searchTV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(44)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}

extension SearchResultVC: UITableViewDelegate { }
extension SearchResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let studyInfoNum = responseStudyInfo?.data.count ?? 0
        
        if studyInfoNum == 0 {
            searchTV.setEmptyView(title: searchResult, message: "에 해당하는 검색 결과가 없습니다.")
        } else {
            searchTV.restore()
        }
        
        return studyInfoNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTVC", for: indexPath) as! StudyTVC
        
        let studyInfo = responseStudyInfo
        cell.addContentView()
        cell.selectionStyle = .none
        
        switch studyInfo?.status {
        case 200:
            if studyInfo?.data.count == 0 {
                cell.studyImageView.isHidden = true
                cell.studyTitleLabel.isHidden = true
                cell.studyInfoTextView.isHidden = true
                cell.isPenaltyLabel.isHidden = true
                cell.memberButton.isHidden = true
                cell.placeButton.isHidden = true
                
                let emptyLabel = UILabel()
                emptyLabel.text = "참여중인 스터디가 없습니다😳"
                cell.addSubview(emptyLabel)
                emptyLabel.snp.makeConstraints{ (make) in
                    make.centerX.equalToSuperview()
                    make.top.equalToSuperview().offset(100)
                    make.bottom.equalToSuperview().offset(-100)
                }
            } else {
                cell.studyImageView.isHidden = false
                cell.studyTitleLabel.isHidden = false
                cell.studyInfoTextView.isHidden = false
                cell.isPenaltyLabel.isHidden = false
                cell.memberButton.isHidden = false
                cell.placeButton.isHidden = false
                
                cell.studyInfo = studyInfo?.data[indexPath.row]
                cell.initCell()
                cell.addContentView()
            }
            
        case 400, 406, 411, 500, 420, 421, 422, 423:
            cell.studyImageView.isHidden = true
            cell.studyTitleLabel.isHidden = true
            cell.studyInfoTextView.isHidden = true
            cell.isPenaltyLabel.isHidden = true
            cell.memberButton.isHidden = true
            cell.placeButton.isHidden = true
            
            let emptyLabel = UILabel()
            emptyLabel.text = "참여중인 스터디가 없습니다😢"
            cell.addSubview(emptyLabel)
            emptyLabel.snp.makeConstraints{ (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
        default:
            cell.studyImageView.isHidden = true
            cell.studyTitleLabel.isHidden = true
            cell.studyInfoTextView.isHidden = true
            cell.isPenaltyLabel.isHidden = true
            cell.memberButton.isHidden = true
            cell.placeButton.isHidden = true
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let studyDetailSB = UIStoryboard(name: "StudyDetail", bundle: nil)
        let showStudyDetailVC = studyDetailSB.instantiateViewController(withIdentifier: "StudyDetail") as! StudyDetailVC
        showStudyDetailVC.studyID = responseStudyInfo?.data[indexPath.row].id ?? 1
        
        self.navigationController?.pushViewController(showStudyDetailVC, animated: true)
    }
    
}

extension SearchResultVC {
    func getStudyInfoSearchService(_ token: String, _ name: String) {
        StudyService.shared.getSearchList(token, name) { result in
            switch result {
            case .success(let res):
                let responseStudyList = res as! StudyList
                
                switch responseStudyList.status {
                case 200:
                    self.responseStudyInfo = responseStudyList
                    
                    self.searchTV.reloadData()
                    
                case 400, 406, 411, 500, 420, 421, 422, 423:
                    self.simpleAlert(title: responseStudyList.message, message: "")
                    self.searchTV.setEmptyView(title: "스터디 목록을 불러오는데 실패하였습니다😢", message: "")
                    
                default:
                    self.simpleAlert(title: "오류가 발생하였습니다", message: "")
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
