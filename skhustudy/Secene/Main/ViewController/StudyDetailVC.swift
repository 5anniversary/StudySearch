//
//  StudyDetail.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/04/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then
import SnapKit

import SwiftKeychainWrapper

class StudyDetailVC: UIViewController {
    
    // MARK: - UI components
    
    @IBOutlet var studyWeeksTV: UITableView!
    
    // MARK: - Variables and Properties
    
    var studyID: Int = 0
    
    var studyChapterList: StudyChapterList?
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studyWeeksTV.dataSource = self
        studyWeeksTV.delegate = self
        
        // Register the custom header view
        studyWeeksTV.register(UINib(nibName: "StudyDetailHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "StudyDetailHeaderView")
        // Register the custom cell
        studyWeeksTV.register(UINib(nibName: "StudyWeekTVC", bundle: nil), forCellReuseIdentifier: "StudyWeekTVC")
        // Register the custom footer view
        studyWeeksTV.register(UINib(nibName: "StudyDetailFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "StudyDetailFooterView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getStudyChapterListService(completionHandler: {returnedData-> Void in
            self.studyWeeksTV.reloadData()
        })
    }
    
    // MARK: - Helper
    
}

// MARK: - UITableView

extension StudyDetailVC : UITableViewDelegate { }

extension StudyDetailVC : UITableViewDataSource {
    
    // Table HeaderView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StudyDetailHeaderView") as? StudyDetailHeaderView
        
        headerView?.studyDetailVC = self
        headerView?.studyID = studyID
        headerView?.awakeFromNib()
        
        return headerView
    }

    // Table Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyWeekTVC", for: indexPath) as! StudyWeekTVC
        
        cell.selectionStyle = .none
        
        switch studyChapterList?.status {
        case 200:
            if studyChapterList?.data.count == 0 {
                cell.weeksLabel.isHidden = true
                cell.subjectLabel.isHidden = true
                cell.dateLabel.isHidden = true
                cell.locationLabel.isHidden = true
                
                let emptyLabel = UILabel()
                emptyLabel.text = "불러올 주차별 내용이 없습니다😳"
                cell.addSubview(emptyLabel)
                emptyLabel.snp.makeConstraints{ (make) in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
            } else {
                cell.weeksLabel.isHidden = false
                cell.subjectLabel.isHidden = false
                cell.dateLabel.isHidden = false
                cell.locationLabel.isHidden = false
                
                cell.studyChapterInfo = studyChapterList?.data[indexPath.row]
                cell.initCell()
            }
            
        case 400, 406, 411, 500, 420, 421, 422, 423:
            cell.weeksLabel.isHidden = true
            cell.subjectLabel.isHidden = true
            cell.dateLabel.isHidden = true
            cell.locationLabel.isHidden = true
            
            let emptyLabel = UILabel()
            emptyLabel.text = "주차별 정보를 불러오는데 실패하였습니다😢"
            cell.addSubview(emptyLabel)
            emptyLabel.snp.makeConstraints{ (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
        default:
            cell.weeksLabel.isHidden = true
            cell.subjectLabel.isHidden = true
            cell.dateLabel.isHidden = true
            cell.locationLabel.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var chapterList = studyChapterList?.data.count ?? 0
        
        if chapterList == 0 {
            chapterList += 1
        }
        
        return chapterList
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let weekDetailSB = UIStoryboard(name: "WeekDetail", bundle: nil)
        let showWeekDetailVC = weekDetailSB.instantiateViewController(withIdentifier: "WeekDetail") as! WeekDetailVC
        
        self.navigationController?.pushViewController(showWeekDetailVC, animated: true)
    }

    // Table FooterView
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StudyDetailFooterView") as? StudyDetailFooterView
        
        footerView?.studyID = studyID
        footerView?.initStudyDetail()
        footerView?.studyDetailVC = self
        
        return footerView
    }
}

// MARK: - Study Chapter List Service

extension StudyDetailVC {
    
    func getStudyChapterListService(completionHandler: @escaping (_ returnedData: StudyChapterList) -> Void) {
        let token = KeychainWrapper.standard.string(forKey: "token") ?? ""
        StudyService.shared.getStudyChapterList(token: token, id: studyID) { result in
        
            switch result {
                case .success(let res):
                    let responseStudyChapterList = res as! StudyChapterList
                    
                    switch responseStudyChapterList.status {
                    case 200:
                        self.studyChapterList = responseStudyChapterList
                        
                        completionHandler(self.studyChapterList!)
                        
                    case 400, 406, 411, 500, 420, 421, 422, 423:
                        self.simpleAlert(title: responseStudyChapterList.message, message: "")
                        
                    default:
                        let presentVC = self.presentingViewController
                        self.dismiss(animated: true, completion: {
                            presentVC?.simpleAlert(title: "오류가 발생하였습니다", message: "")
                        })
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
