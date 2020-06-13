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
    
    let chatOrCreateButton = UIButton()
    
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
        studyWeeksTV.register(StudyDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: "StudyDetailHeaderView")
        // Register the custom cell
        studyWeeksTV.register(StudyWeekTVC.self, forCellReuseIdentifier: "StudyWeekTVC")
        
        addChatOrCreateButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getStudyChapterListService(completionHandler: {returnedData-> Void in
            self.studyWeeksTV.reloadData()
        })
    }
    
    func addChatOrCreateButton() {
        _ = chatOrCreateButton.then {
            $0.setTitle("챕터 생성", for: .normal)
            $0.titleLabel?.font = Font.studyContentsLabel
            $0.makeRounded(cornerRadius: 15)
            $0.tintColor = .white
            $0.backgroundColor = .signatureColor
            
            $0.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
            
            $0.addTarget(self, action: #selector(didTapChatOrCreateButton), for: .touchUpInside)
        }
        
        view.addSubview(chatOrCreateButton)
        
        chatOrCreateButton.snp.makeConstraints{ make in
            make.width.equalTo(90)
            make.height.equalTo(35)
            make.centerX.equalToSuperview()
            
            var tabBarHeight = tabBarController?.tabBar.frame.size.height ?? 0
            tabBarHeight = tabBarHeight + CGFloat(10.0)
            make.bottom.equalToSuperview().inset(tabBarHeight)
        }
    }
    
    @objc func didTapChatOrCreateButton() {
        
        let CreateWeekSB = UIStoryboard(name: "CreateWeek", bundle: nil)
        let showCreateWeekVC = CreateWeekSB.instantiateViewController(withIdentifier: "CreateWeekVC") as! CreateWeekVC
        
        showCreateWeekVC.studyID = studyID
        
        navigationController?.pushViewController(showCreateWeekVC, animated: true)
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
        headerView?.initHeaderView()
        
        return headerView
    }

    // Table Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyWeekTVC", for: indexPath) as! StudyWeekTVC
        
        cell.selectionStyle = .none
        
        switch studyChapterList?.status {
        case 200:
            if studyChapterList?.data.count == 0 {
                cell.numberLabel.isHidden = true
                cell.dateLabel.isHidden = true
                cell.titleLabel.isHidden = true
                cell.placeButton.isHidden = true
                cell.placeImageView.isHidden = true
                
                let emptyLabel = UILabel()
                emptyLabel.text = "불러올 챕터가 없습니다😳"
                cell.addSubview(emptyLabel)
                emptyLabel.snp.makeConstraints{ (make) in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
            } else {
                cell.numberLabel.isHidden = false
                cell.dateLabel.isHidden = false
                cell.titleLabel.isHidden = false
                cell.placeButton.isHidden = false
                cell.placeImageView.isHidden = false
                
                cell.studyChapterInfo = studyChapterList?.data[indexPath.row]
                cell.studyOrder = (studyChapterList?.data.count ?? 0 + 1) - indexPath.row
                cell.initCell()
                cell.addContentView()
            }
            
        case 400, 406, 411, 500, 420, 421, 422, 423:
            cell.numberLabel.isHidden = true
            cell.dateLabel.isHidden = true
            cell.titleLabel.isHidden = true
            cell.placeButton.isHidden = true
            cell.placeImageView.isHidden = true
            
            let emptyLabel = UILabel()
            emptyLabel.text = "챕터 정보를 불러오는데 실패하였습니다😢"
            cell.addSubview(emptyLabel)
            emptyLabel.snp.makeConstraints{ (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
        default:
            cell.numberLabel.isHidden = true
            cell.dateLabel.isHidden = true
            cell.titleLabel.isHidden = true
            cell.placeButton.isHidden = true
            cell.placeImageView.isHidden = true
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
        let popUpViewVC = ChapterDetailPopUpVC()
        popUpViewVC.modalPresentationStyle = .overCurrentContext
        tabBarController?.present(popUpViewVC, animated: true, completion: nil)
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
