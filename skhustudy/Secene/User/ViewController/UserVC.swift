//
//  UserVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SnapKit
import Then

class UserVC: UIViewController {
    
    // MARK: - UI components
    
    @IBOutlet var userTV: UITableView!
    
    // MARK: - Variables and Properties
    
    var userInfo: User?
    var userStudyInfo: StudyList?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTV.dataSource = self
        self.userTV.delegate = self
        
        // Register the custom header view
        userTV.register(UINib(nibName: "UserHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "UserHeaderView")
        // Register the StudyCell from Main tab
        userTV.register(StudyTVC.self, forCellReuseIdentifier: "StudyTVC")
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "설정", style: .done, target: self, action: #selector(settingProfile))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfoService(completionHandler: {(returnedData) -> Void in
            self.getUserStudyInfoService(completionHandler: {(returnedData)-> Void in
                self.userTV.reloadData()
            })
        })
    }
    
    // MARK: - Helper
    
    @objc public func settingProfile() {
        let sb = UIStoryboard(name: "AddMoreUserInformation", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "AddUserInfoVC") as! AddUserInfoVC
        
        vc.isEditingMode = true
        
        vc.confirmButton.title = "수정하기"
//        vc.nextButton.isEnabled = false
        
        vc.navigationItem.title = "프로필 수정"
        vc.profileImageView.imageFromUrl(self.userInfo?.data.image, defaultImgPath: "")
        vc.profileImageView.contentMode = .scaleToFill
        vc.nicknameTextField.text = userInfo?.data.nickName
        let intAge = userInfo?.data.age ?? 0
        vc.ageTextField.text = String(intAge)
        vc.genderTextField.text = userInfo?.data.sex == 0 ? "남" : "여"
        vc.locationTextField.text = userInfo?.data.location
        vc.selfIntroductionTextView.text = userInfo?.data.content
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

    // MARK: - TableView

extension UserVC: UITableViewDelegate { }
extension UserVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UserHeaderView") as? UserHeaderView
        
        headerView?.userInfo = userInfo
        headerView?.initUserInfo()
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTVC", for: indexPath) as! StudyTVC
        
        cell.selectionStyle = .none
        
        let userStudyList = userStudyInfo
        
        switch userStudyList?.status {
        case 200:
            if userStudyList?.data.count == 0 {
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
                
                cell.studyInfo = userStudyInfo?.data[indexPath.row]
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
        
        showStudyDetailVC.studyID = userStudyInfo?.data[indexPath.row].id ?? 0
        
        self.navigationController?.pushViewController(showStudyDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var userStudyList = userStudyInfo?.data.count ?? 0
        
        if userStudyList == 0 {
            userStudyList += 1
        }
        
        return userStudyList
    }
    
}

// MARK: - 사용자 정보 서버 연결

extension UserVC {
    
    func getUserInfoService(completionHandler: @escaping (_ returnedData: User) -> Void ) {
        UserService.shared.getUserInfo() { result in
        
            switch result {
                case .success(let res):
                    self.userInfo = res as? User
                    completionHandler(self.userInfo!)
                
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

    func getUserStudyInfoService(completionHandler: @escaping (_ returnedData: StudyList) -> Void ) {
        UserService.shared.getUserStudyInfo() { result in
        
            switch result {
                case .success(let res):
                    let responseStudyList = res as! StudyList
                    
                    switch responseStudyList.status {
                    case 200:
                        self.userStudyInfo = responseStudyList
                        print(responseStudyList)
                        print("이것 좀 보세요오오오오오오 : ", self.userStudyInfo)
                        completionHandler(self.userStudyInfo!)
                        
                    case 400, 406, 411, 500, 420, 421, 422, 423:
                        self.simpleAlert(title: responseStudyList.message, message: "")
                        self.userTV.setEmptyView(title: "스터디 목록을 불러오는데 실패하였습니다😢", message: "")
                        
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
