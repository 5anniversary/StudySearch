//
//  AllVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/16.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SnapKit

class AllVC: UIViewController {

    // MARK: - UI components
    
    let tableView = UITableView().then {_ in
        
    }
    
    // MARK: - Variables and Properties
    var studyList: StudyList?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        self.view.backgroundColor = .blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStudyListService()
    }
    
    // MARK: - Helper
    func setTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StudyTVC")
        tableView.register(UINib(nibName: "StudyTVC", bundle: nil), forCellReuseIdentifier: "StudyTVC")
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - UITableView
extension AllVC : UITableViewDelegate { }

extension AllVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTVC", for: indexPath) as! StudyTVC

        cell.selectionStyle = .none
        
        cell.studyInfo = studyList?.data[indexPath.row]
        cell.initCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let studyDetailSB = UIStoryboard(name: "StudyDetail", bundle: nil)
        let showStudyDetailVC = studyDetailSB.instantiateViewController(withIdentifier: "StudyDetail") as! StudyDetailVC
        
        self.navigationController?.pushViewController(showStudyDetailVC, animated: true)
    }
}

// MARK: - Study Service

extension AllVC {
    
    func getStudyListService() {
        StudyService.shared.getStudyList() { result in
        
            switch result {
                case .success(let res):
                    let responseStudyList = res as! StudyList
                    
                    switch responseStudyList.status {
                    case 200:
                        self.studyList = responseStudyList
                        
                        self.tableView.reloadData()
                        
                    case 400, 406, 411, 500, 420, 421, 422, 423:
                        self.simpleAlert(title: responseStudyList.message, message: "")
                        self.tableView.setEmptyView(title: "스터디 목록을 불러오는데 실패하였습니다😢", message: "")
                        
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

