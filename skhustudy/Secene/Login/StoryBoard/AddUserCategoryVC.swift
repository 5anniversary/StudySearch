//
//  AddUserCategoryVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import FirebaseStorage
import FirebaseFirestore
import SwiftKeychainWrapper
import Then

class AddUserCategoryVC: UIViewController {
    
    var categories: [Category] = []
    var seletedCategories = [String]()
    var imageURL: String = ""
    var nickname: String = ""
    var age: Int = 0
    var gender: Int = 0
    var location: String = ""
    var introduceMe: String = ""
    
    let selectCategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.allowsMultipleSelection = true
        $0.backgroundColor = UIColor.white
    }
    
    lazy var completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(didTapCompleteButton))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "카테고리 선택"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.rightBarButtonItem = completeButton
        completeButton.isEnabled = false
        createCollectionView()
        addSubView()
        fetchCategory()
    }
    private func createCollectionView() {
        selectCategoryCollectionView.delegate = self
        selectCategoryCollectionView.dataSource = self
        selectCategoryCollectionView.alwaysBounceVertical = true
        selectCategoryCollectionView.register(AddUserCategoryCell.self, forCellWithReuseIdentifier: AddUserCategoryCell.identifier)
    }
    
    @objc private func didTapCompleteButton() {
        print("didTapCompleteButton")
        addUserInfoService()
    }
    
}

// MARK: - Extension

extension AddUserCategoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddUserCategoryCell.identifier, for: indexPath) as! AddUserCategoryCell
    
        cell.categoryLabel.text = "#\(categories[indexPath.row].name)"
        cell.setRounded(radius: CGFloat(roundf(Float(cell.frame.size.width / 2.0))))
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.8
        cell.layer.masksToBounds = false
        return cell
    }
    
}

extension AddUserCategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.count == 3 {
                completeButton.isEnabled = true
                seletedCategories.removeAll()
                for item in selectedItems {
                    self.seletedCategories.append(categories[item.row].name)
                }
                
            } else if selectedItems.count > 3{
                completeButton.isEnabled = true
                collectionView.deselectItem(at: indexPath, animated: false)
            } else {
                seletedCategories.removeAll()
                for item in selectedItems {
                    self.seletedCategories.append(categories[item.row].name)
                }
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.count < 3 {
                completeButton.isEnabled = false
            }
        }
    }
    
}


extension AddUserCategoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3.0 - 45
        let height = width
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }
    
    // Cell 간 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    // 행 간 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    
}

// MARK: - Add User Info Serivce

extension AddUserCategoryVC {
    func fetchCategory() {
        UserService.shared.getCategory { result in
            switch result {
            case .success(let data):
                self.categories = data as! [Category]
                DispatchQueue.main.async {
                    self.selectCategoryCollectionView.reloadData()
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
    
    func addUserInfoService() {
        guard let token = KeychainWrapper.standard.string(forKey: "token") else { return }
        UserService.shared.modifyUserInfo(token: token, age: age, gender: gender, nickname: nickname, introduceMe: introduceMe, location: location, pickURL: imageURL, category: seletedCategories) { (result) in
            switch result {
            case .success(let result):
                let user = result as! User
                let userData = user.data
                
                //  response로 uid 받아서 firebase에 저장하기.
                let ref = Firestore.firestore().collection("users").document("\(userData.userID)")
                ref.setData([
                    "uid": userData.userID,
                    "imageURL": userData.image,
                    "nickname": userData.nickName
                ]) { (error) in
                    if error == nil {
                        // TODO: root view 바꾸기
                        let sb = UIStoryboard(name: "TabBar", bundle: nil)
                        let vc = sb.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                        sceneDelegate.window?.rootViewController = vc
                    }
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

