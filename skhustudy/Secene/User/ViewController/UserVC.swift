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
import SwiftKeychainWrapper

class UserVC: UIViewController {
    
    // MARK: - UI components
    
    let tabCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TabCVC.self, forCellWithReuseIdentifier: "TabCVC")
        cv.scrollIndicatorInsets = .zero
        //        cv.isScrollEnabled = false
        return cv
    }()
    
    let pageCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PageCVC.self, forCellWithReuseIdentifier: "PageCVC")
        cv.isPagingEnabled = true
        return cv
    }()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let imageView = UIImageView()
    let chatButton = UIButton()
    let nameLabel = UILabel()
    let ageLabel = UILabel()
    let sexLabel = UILabel()
    let categoryLabel = UILabel()
    let locationLabel = UILabel()
    let pinImageView = UIImageView()
    let contentTextView = UITextView()
    let highlightView = UIView()
    let ingTableView = UITableView()
    let endTableView = UITableView()
    
    
    
    // MARK: - Variables and Properties
    
    var userInfo: UserData?
    var direction: CGFloat?
    var constraints: [NSLayoutConstraint] = []
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1200 as CGFloat
    var userStudyInfo: StudyList?
    
    var ingStudyInfo: [StudyListData] = []
    var endStudyInfo: [StudyListData] = []
    
    var userID = KeychainWrapper.standard.string(forKey: "userID")
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserInfoService()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "설정",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(goSettingView))
        
        set()
        setTabbar()
        
        if chatButton.titleLabel?.text == "프로필 설정" {
            chatButton.addTarget(self, action: #selector(settingProfile), for: .touchUpInside)
        } else { // 채팅 하기 버튼일때 채팅 연결
            
        }
    }
    
    // MARK: - Helper
    
    
    @objc public func settingProfile() {
        let sb = UIStoryboard(name: "AddMoreUserInformation", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "AddUserInfoVC") as! AddUserInfoVC
        
        vc.isEditingMode = true
        
        vc.navigationItem.title = "프로필 수정"
        vc.profileImageView.imageFromUrl(self.userInfo?.image, defaultImgPath: "")
        vc.profileImageView.contentMode = .scaleToFill
        vc.nicknameTextField.text = userInfo?.nickName
        let intAge = userInfo?.age ?? 0
        vc.ageTextField.text = String(intAge)
        vc.genderTextField.text = userInfo?.sex == 0 ? "남" : "여"
        vc.locationTextField.text = userInfo?.location
        vc.selfIntroductionTextView.text = userInfo?.content
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setTabbar() {
        tabCV.delegate = self
        tabCV.dataSource = self
        ingTableView.delegate = self
        ingTableView.dataSource = self
        endTableView.delegate = self
        endTableView.dataSource = self
        let firstIndexPath = IndexPath(item: 0, section: 0)
        // delegate 호출
        collectionView(tabCV, didSelectItemAt: firstIndexPath)        // cell select
        tabCV.selectItem(at: firstIndexPath, animated: false, scrollPosition: .right)
    }
    
    @objc func goSettingView(){
        
    }
}

extension UserVC: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let yOffset = scrollView.contentOffset.y
        
        if scrollView == self.scrollView {
            if yOffset >= scrollViewContentHeight - screenHeight {
                scrollView.isScrollEnabled = false
            }
        }
        
        
        
        if scrollView == pageCV {
            let index = Int(targetContentOffset.pointee.x / tabCV.frame.width)
            let indexPath = IndexPath(item: index, section: 0)
            
            tabCV.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
            collectionView(tabCV, didSelectItemAt: indexPath)
            
            if Int(direction ?? 0) > 0 {
                // >>>> 스와이프하면 스크롤은 중앙으Replace 'didSelectItemAt' with 'cellForItemAt'로
                tabCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                collectionView(tabCV, didSelectItemAt: indexPath)
            } else {
                // <<<< 스와이프하면 스크롤은 왼쪽으로
                tabCV.scrollToItem(at: indexPath, at: .left, animated: true)
                collectionView(tabCV, didSelectItemAt: indexPath)
            }
        }
        
        if scrollView == tabCV {
            let index = Int(targetContentOffset.pointee.x / pageCV.frame.width)
            let indexPath = IndexPath(item: index, section: 0)
            
            pageCV.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
            collectionView(pageCV, didSelectItemAt: indexPath)
            
            if Int(direction ?? 0) > 0 {
                // >>>> 스와이프하면 스크롤은 중앙으Replace 'didSelectItemAt' with 'cellForItemAt'로
                pageCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                collectionView(pageCV, didSelectItemAt: indexPath)
            } else {
                // <<<< 스와이프하면 스크롤은 왼쪽으로
                pageCV.scrollToItem(at: indexPath, at: .left, animated: true)
                collectionView(pageCV, didSelectItemAt: indexPath)
            }
        }
        
    }
    
    // 스크롤 방향을 알아내기 위한 함수
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
        
        if velocity.x < 0 {
            // -: 오른쪽에서 왼쪽 <<<
            direction = -1
        } else if velocity.x > 0 {
            // +: 왼쪽에서 오른쪽 >>>
            direction = 1
        } else {
            
        }
    }
    
}
extension UserVC: UICollectionViewDelegate { }
extension UserVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView:UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.tabCV:
            return CGSize(width: self.view.frame.width/2, height: collectionView.frame.height)
        case self.pageCV:
            return CGSize(width: self.view.frame.width, height: collectionView.frame.height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
}
extension UserVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.tabCV:
            guard let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCVC", for: indexPath) as? TabCVC else {return UICollectionViewCell()}
            tabCell.backgroundColor = .white
            if indexPath.row == 0 {
                tabCell.titleLabel.text = "진행중인 스터디"

            } else {
                tabCell.titleLabel.text = "종료된 스터디"
                tabCell.titleLabel.textColor = .veryLightPink
            }
            
            return tabCell
            
        case self.pageCV:
            guard let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCVC", for: indexPath) as? PageCVC else {return UICollectionViewCell()}
            
            if indexPath.row == 0 {
                pageCell.addSubview(ingTableView)
                ingTableView.snp.makeConstraints { (make) in
                    make.top.equalTo(pageCell.snp.top)
                    make.trailing.equalTo(pageCell.snp.trailing)
                    make.leading.equalTo(pageCell.snp.leading)
                    make.bottom.equalTo(pageCell.snp.bottom)
                }
                self.ingTableView.register(StudyTVC.self, forCellReuseIdentifier: "StudyTVC")
            } else {
                pageCell.addSubview(endTableView)
                endTableView.snp.makeConstraints { (make) in
                    make.top.equalTo(pageCell.snp.top)
                    make.trailing.equalTo(pageCell.snp.trailing)
                    make.leading.equalTo(pageCell.snp.leading)
                    make.bottom.equalTo(pageCell.snp.bottom)
                }
                self.endTableView.register(StudyTVC.self, forCellReuseIdentifier: "StudyTVC")
            }
            
            pageCV.backgroundColor = .white
            
            return pageCell
            
        default:
            return UICollectionViewCell()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabCV {

            pageCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
}

extension UserVC: UITableViewDelegate {}
extension UserVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.ingTableView:
            let ingStudyInfoNum = self.ingStudyInfo.count
            
            if ingStudyInfoNum == 0 {
                ingTableView.setEmptyView(title: "진행중인 스터디가 없습니다", message: "스터디에 참여해보세요‼️")
            } else {
                ingTableView.restore()
            }

            return ingStudyInfoNum
        case self.endTableView:
            let endStudyInfoNum = self.endStudyInfo.count
            
            if endStudyInfoNum == 0 {
                endTableView.setEmptyView(title: "아직 종료된 스터디가 없습니다.", message: "")
            } else {
                endTableView.restore()
            }

            return endStudyInfoNum
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.ingTableView:
            guard let ingCell = tableView.dequeueReusableCell(withIdentifier: "StudyTVC",
                                                              for: indexPath) as? StudyTVC else
            {return UITableViewCell()}
            let userStudyList = userStudyInfo
            
            ingCell.addContentView()

            switch userStudyList?.status {
            case 200:
                if userStudyList?.data.count == 0 {
                    ingCell.studyImageView.isHidden = true
                    ingCell.studyTitleLabel.isHidden = true
                    ingCell.studyInfoTextView.isHidden = true
                    ingCell.isPenaltyLabel.isHidden = true
                    ingCell.memberButton.isHidden = true
                    ingCell.placeButton.isHidden = true
                    
                    let emptyLabel = UILabel()
                    emptyLabel.text = "참여중인 스터디가 없습니다😳"
                    ingCell.addSubview(emptyLabel)
                    emptyLabel.snp.makeConstraints{ (make) in
                        make.centerX.equalToSuperview()
                        make.top.equalToSuperview().offset(100)
                        make.bottom.equalToSuperview().offset(-100)
                    }
                } else {
                    ingCell.studyImageView.isHidden = false
                    ingCell.studyTitleLabel.isHidden = false
                    ingCell.studyInfoTextView.isHidden = false
                    ingCell.isPenaltyLabel.isHidden = false
                    ingCell.memberButton.isHidden = false
                    ingCell.placeButton.isHidden = false
                    
                    ingCell.studyInfo = ingStudyInfo[indexPath.row]
                    ingCell.initCell()
                    ingCell.addContentView()
                }
                
            case 400, 406, 411, 500, 420, 421, 422, 423:
                ingCell.studyImageView.isHidden = true
                ingCell.studyTitleLabel.isHidden = true
                ingCell.studyInfoTextView.isHidden = true
                ingCell.isPenaltyLabel.isHidden = true
                ingCell.memberButton.isHidden = true
                ingCell.placeButton.isHidden = true
                
                let emptyLabel = UILabel()
                emptyLabel.text = "참여중인 스터디가 없습니다😢"
                ingCell.addSubview(emptyLabel)
                emptyLabel.snp.makeConstraints{ (make) in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
                
            default:
                ingCell.studyImageView.isHidden = true
                ingCell.studyTitleLabel.isHidden = true
                ingCell.studyInfoTextView.isHidden = true
                ingCell.isPenaltyLabel.isHidden = true
                ingCell.memberButton.isHidden = true
                ingCell.placeButton.isHidden = true
            }
            
            
            return ingCell
        case self.endTableView:
            guard let endCell = tableView.dequeueReusableCell(withIdentifier: "StudyTVC",
                                                              for: indexPath) as? StudyTVC else
            {return UITableViewCell()}
            
            endCell.addContentView()
            
            let userStudyList = userStudyInfo
            
            endCell.addContentView()

            switch userStudyList?.status {
            case 200:
                if userStudyList?.data.count == 0 {
                    endCell.studyImageView.isHidden = true
                    endCell.studyTitleLabel.isHidden = true
                    endCell.studyInfoTextView.isHidden = true
                    endCell.isPenaltyLabel.isHidden = true
                    endCell.memberButton.isHidden = true
                    endCell.placeButton.isHidden = true
                    
                    let emptyLabel = UILabel()
                    emptyLabel.text = "참여중인 스터디가 없습니다😳"
                    endCell.addSubview(emptyLabel)
                    emptyLabel.snp.makeConstraints{ (make) in
                        make.centerX.equalToSuperview()
                        make.top.equalToSuperview().offset(100)
                        make.bottom.equalToSuperview().offset(-100)
                    }
                } else {
                    endCell.studyImageView.isHidden = false
                    endCell.studyTitleLabel.isHidden = false
                    endCell.studyInfoTextView.isHidden = false
                    endCell.isPenaltyLabel.isHidden = false
                    endCell.memberButton.isHidden = false
                    endCell.placeButton.isHidden = false
                    
                    endCell.studyInfo = ingStudyInfo[indexPath.row]
                    endCell.initCell()
                    endCell.addContentView()
                }
                
            case 400, 406, 411, 500, 420, 421, 422, 423:
                endCell.studyImageView.isHidden = true
                endCell.studyTitleLabel.isHidden = true
                endCell.studyInfoTextView.isHidden = true
                endCell.isPenaltyLabel.isHidden = true
                endCell.memberButton.isHidden = true
                endCell.placeButton.isHidden = true
                
                let emptyLabel = UILabel()
                emptyLabel.text = "참여중인 스터디가 없습니다😢"
                endCell.addSubview(emptyLabel)
                emptyLabel.snp.makeConstraints{ (make) in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
                
            default:
                endCell.studyImageView.isHidden = true
                endCell.studyTitleLabel.isHidden = true
                endCell.studyInfoTextView.isHidden = true
                endCell.isPenaltyLabel.isHidden = true
                endCell.memberButton.isHidden = true
                endCell.placeButton.isHidden = true
            }

            
            return endCell
        default:
            return UITableViewCell()
        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
        case self.ingTableView:
            let studyDetailSB = UIStoryboard(name: "StudyDetail", bundle: nil)
            let showStudyDetailVC = studyDetailSB.instantiateViewController(withIdentifier: "StudyDetail") as! StudyDetailVC
            showStudyDetailVC.studyID = ingStudyInfo[indexPath.row].id

            self.navigationController?.pushViewController(showStudyDetailVC, animated: true)

        case self.endTableView:
            let studyDetailSB = UIStoryboard(name: "StudyDetail", bundle: nil)
            let showStudyDetailVC = studyDetailSB.instantiateViewController(withIdentifier: "StudyDetail") as! StudyDetailVC
            showStudyDetailVC.studyID = endStudyInfo[indexPath.row].id

            self.navigationController?.pushViewController(showStudyDetailVC, animated: true)

        default:
            break
        }
    }

}


// MARK: - 사용자 정보 서버 연결
//
extension UserVC {
    
    func getUserInfoService() {
        UserService.shared.getUserInfo(userID ?? "") { result in
            
            switch result {
            case .success(let res):
                let response = res as? User
                self.userInfo = response?.data
                self.setInfo()
                self.getUserStudyInfoService()
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
    
    func getUserStudyInfoService() {
        UserService.shared.getUserStudyInfo() { result in
            switch result {
            case .success(let res):
                let responseStudyList = res as! StudyList
                
                switch responseStudyList.status {
                case 200:
                    self.userStudyInfo = responseStudyList

                    for i in 0..<(self.userStudyInfo?.data.count ?? 0)  {
                        if (self.userStudyInfo?.data[i].isEnd ?? true) {
                            self.endStudyInfo.append((self.userStudyInfo?.data[i])!)
                        } else {
                            self.ingStudyInfo.append((self.userStudyInfo?.data[i])!)
                        }
                    }
                    
                    
                    self.endTableView.reloadData()
                    self.ingTableView.reloadData()
                    
                case 400, 406, 411, 500, 420, 421, 422, 423:
                    self.simpleAlert(title: responseStudyList.message, message: "")
                    self.ingTableView.setEmptyView(title: "스터디 목록을 불러오는데 실패하였습니다😢", message: "")
                    
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
