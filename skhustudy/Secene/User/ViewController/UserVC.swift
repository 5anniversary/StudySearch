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
    
    
    
    // MARK: - Variables and Properties
    
    var userInfo: UserData?
    var direction: CGFloat?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserInfoService()
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        set()
        setTabbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    // MARK: - Helper
    
    
    @objc public func settingProfile() {
        let sb = UIStoryboard(name: "AddMoreUserInformation", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "AddUserInfoVC") as! AddUserInfoVC
        
        vc.isEditingMode = true
        
        vc.navigationItem.title = "프로필 수정"
        //        vc.profileImageView.imageFromUrl(self.userInfo?.data.image, defaultImgPath: "")
        //        vc.profileImageView.contentMode = .scaleToFill
        //        vc.nicknameTextField.text = userInfo?.data.nickName
        //        let intAge = userInfo?.data.age ?? 0
        //        vc.ageTextField.text = String(intAge)
        //        vc.genderTextField.text = userInfo?.data.sex == 0 ? "남" : "여"
        //        vc.locationTextField.text = userInfo?.data.location
        //        vc.selfIntroductionTextView.text = userInfo?.data.content
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setTabbar() {
        tabCV.delegate = self
        tabCV.dataSource = self
        let firstIndexPath = IndexPath(item: 0, section: 0)
        // delegate 호출
        collectionView(tabCV, didSelectItemAt: firstIndexPath)        // cell select
        tabCV.selectItem(at: firstIndexPath, animated: false, scrollPosition: .right)
    }
}

extension UserVC: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == tabCV {
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
                //                tabCell.titleLabel.textColor = .signatureColor
            } else {
                tabCell.titleLabel.text = "종료된 스터디"
                tabCell.titleLabel.textColor = .veryLightPink
            }
            
            return tabCell
            
        case self.pageCV:
            guard let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCVC", for: indexPath) as? PageCVC else {return UICollectionViewCell()}
            
            if indexPath.row == 0 {
                pageCell.backgroundColor = .yellow
            } else {
                pageCell.backgroundColor = .blue
            }
            
            pageCV.backgroundColor = .white
            pageCV.backgroundView?.backgroundColor = .white
            
            return pageCell
            
        default:
            return UICollectionViewCell()
            
        }
        //        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabCV {
            let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCVC",
                                                   for: indexPath) as? TabCVC
            
            tabCell?.isSelected = true

        }
    }
    
    
}
// MARK: - TableView

//extension UserVC: UITableViewDelegate { }
//extension UserVC: UITableViewDataSource {

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UserHeaderView") as? UserHeaderView
//
//        headerView?.userInfo = userInfo
//        headerView?.initUserInfo()
//
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView,
//                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTVC", for: indexPath) as! StudyTVC
//
//        cell.selectionStyle = .none
//
//        let userStudyList = userStudyInfo
//
//        switch userStudyList?.status {
//        case 200:
//            if userStudyList?.data.count == 0 {
//                cell.studyImageView.isHidden = true
//                cell.studyTitleLabel.isHidden = true
//                cell.studyInfoTextView.isHidden = true
//                cell.isPenaltyLabel.isHidden = true
//                cell.memberButton.isHidden = true
//                cell.placeButton.isHidden = true
//
//                let emptyLabel = UILabel()
//                emptyLabel.text = "참여중인 스터디가 없습니다😳"
//                cell.addSubview(emptyLabel)
//                emptyLabel.snp.makeConstraints{ (make) in
//                    make.centerX.equalToSuperview()
//                    make.top.equalToSuperview().offset(100)
//                    make.bottom.equalToSuperview().offset(-100)
//                }
//            } else {
//                cell.studyImageView.isHidden = false
//                cell.studyTitleLabel.isHidden = false
//                cell.studyInfoTextView.isHidden = false
//                cell.isPenaltyLabel.isHidden = false
//                cell.memberButton.isHidden = false
//                cell.placeButton.isHidden = false
//
//                cell.studyInfo = userStudyInfo?.data[indexPath.row]
//                cell.initCell()
//                cell.addContentView()
//            }
//
//        case 400, 406, 411, 500, 420, 421, 422, 423:
//            cell.studyImageView.isHidden = true
//            cell.studyTitleLabel.isHidden = true
//            cell.studyInfoTextView.isHidden = true
//            cell.isPenaltyLabel.isHidden = true
//            cell.memberButton.isHidden = true
//            cell.placeButton.isHidden = true
//
//            let emptyLabel = UILabel()
//            emptyLabel.text = "참여중인 스터디가 없습니다😢"
//            cell.addSubview(emptyLabel)
//            emptyLabel.snp.makeConstraints{ (make) in
//                make.centerX.equalToSuperview()
//                make.centerY.equalToSuperview()
//            }
//
//        default:
//            cell.studyImageView.isHidden = true
//            cell.studyTitleLabel.isHidden = true
//            cell.studyInfoTextView.isHidden = true
//            cell.isPenaltyLabel.isHidden = true
//            cell.memberButton.isHidden = true
//            cell.placeButton.isHidden = true
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let studyDetailSB = UIStoryboard(name: "StudyDetail", bundle: nil)
//        let showStudyDetailVC = studyDetailSB.instantiateViewController(withIdentifier: "StudyDetail") as! StudyDetailVC
//
//        showStudyDetailVC.studyID = userStudyInfo?.data[indexPath.row].id ?? 0
//
//        self.navigationController?.pushViewController(showStudyDetailVC, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var userStudyList = userStudyInfo?.data.count ?? 0
//
//        if userStudyList == 0 {
//            userStudyList += 1
//        }
//
//        return userStudyList
//    }

//}

// MARK: - 사용자 정보 서버 연결
//
extension UserVC {
    
    func getUserInfoService() {
        UserService.shared.getUserInfo() { result in
            
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
    
    //    func getUserStudyInfoService(completionHandler: @escaping (_ returnedData: StudyList) -> Void ) {
    //        UserService.shared.getUserStudyInfo() { result in
    //
    //            switch result {
    //                case .success(let res):
    //                    let responseStudyList = res as! StudyList
    //
    //                    switch responseStudyList.status {
    //                    case 200:
    //                        self.userStudyInfo = responseStudyList
    //                        print(responseStudyList)
    //                        print("이것 좀 보세요오오오오오오 : ", self.userStudyInfo)
    //                        completionHandler(self.userStudyInfo!)
    //
    //                    case 400, 406, 411, 500, 420, 421, 422, 423:
    //                        self.simpleAlert(title: responseStudyList.message, message: "")
    //                        self.userTV.setEmptyView(title: "스터디 목록을 불러오는데 실패하였습니다😢", message: "")
    //
    //                    default:
    //                        self.simpleAlert(title: "오류가 발생하였습니다", message: "")
    //                    }
    //                case .requestErr(_):
    //                    print(".requestErr")
    //                case .pathErr:
    //                    print(".pathErr")
    //                case .serverErr:
    //                    print(".serverErr")
    //                case .networkFail:
    //                    print(".networkFail")
    //            }
    //
    //        }
    //    }
    
}
