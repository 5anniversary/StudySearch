//
//  AddUserCategoryVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit


import FirebaseStorage
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
    var selfIntro: String = ""
    
    let label = UILabel().then {
        $0.text = "관심있는 카테고리를 골라주세요. (최대 3개)"
        $0.font = .boldSystemFont(ofSize: 21.0)
    }
    
    let selectCategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.allowsMultipleSelection = true
        $0.backgroundColor = UIColor.white
    }
    
    let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.alpha = 0.3
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
        $0.backgroundColor = .signatureColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // TODO: Update Database
        updateUserData()
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
        cell.backgroundColor = UIColor.signatureColor
        
        return cell
    }
    
}

extension AddUserCategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.count == 3 {
                completeButton.isEnabled = true
                completeButton.alpha = 1.0
                seletedCategories.removeAll()
                for item in selectedItems {
                    self.seletedCategories.append(categories[item.row].name)
                }
                
            } else if selectedItems.count > 3{
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
                completeButton.alpha = 0.3
            }
        }
    }
    
}

extension AddUserCategoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width*0.48
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
}

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
    
    func updateUserData() {
        guard let token = KeychainWrapper.standard.string(forKey: "token") else { return }
        UserService.shared.modifyUserInfo(token: token, age: age, gender: gender, nickname: nickname,selfIntro: selfIntro, location: location, pickURL: imageURL, category: seletedCategories) { (result) in
            switch result {
            case .success(_):
                print(".success")
                let sb = UIStoryboard(name: "TabBar", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                self.navigationController?.pushViewController(vc, animated: true)
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

