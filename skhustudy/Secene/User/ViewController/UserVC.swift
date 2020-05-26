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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTV.dataSource = self
        self.userTV.delegate = self
        
        // Register the custom header view
        userTV.register(UINib(nibName: "UserHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "UserHeaderView")
        // Register the StudyCell from Main tab
        userTV.register(UINib(nibName: "StudyTVC", bundle: nil), forCellReuseIdentifier: "StudyTVC")
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "설정", style: .done, target: self, action: #selector(settingProfile))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfoService(completionHandler: {(returnedData) -> Void in
            self.userTV.reloadData()
        })
    }
    
    // MARK: - Helper
    
    @objc public func settingProfile() {
        let sb = UIStoryboard(name: "AddMoreUserInformation", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "AddUserInfoVC") as! AddUserInfoVC
        
        vc.isEditingMode = true
        
        vc.nextButton.setTitle("수정하기", for: .normal)
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
        cell.initCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let studyDetailSB = UIStoryboard(name: "StudyDetail", bundle: nil)
        let showStudyDetailVC = studyDetailSB.instantiateViewController(withIdentifier: "StudyDetail") as! StudyDetailVC
        
        self.navigationController?.pushViewController(showStudyDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
    
}
