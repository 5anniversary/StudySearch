//
//  AddUserCategoryVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then

class AddUserCategoryVC: UIViewController {
    
    let categories = ["IT", "English", "Chinese", "Japanese"]
    
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
    }
    
    func createCollectionView() {
        selectCategoryCollectionView.delegate = self
        selectCategoryCollectionView.dataSource = self
        selectCategoryCollectionView.alwaysBounceVertical = true
        selectCategoryCollectionView.register(AddUserCategoryCell.self, forCellWithReuseIdentifier: AddUserCategoryCell.identifier)
    }
    
    @objc func didTapCompleteButton() {
        // TODO: Update Database
        
        let sb = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Extension

extension AddUserCategoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddUserCategoryCell.identifier, for: indexPath) as! AddUserCategoryCell
        
        cell.categoryLabel.text = "#\(categories[indexPath.row])"
        cell.backgroundColor = UIColor.signatureColor
        
        return cell
    }
}

extension AddUserCategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.count <= 3 {
                completeButton.isEnabled = true
                completeButton.alpha = 1.0
                
            } else if selectedItems.count > 3{
                collectionView.deselectItem(at: indexPath, animated: false)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.count == 0 {
                completeButton.isEnabled = false
                completeButton.alpha = 0.3
            }
        }
    }
    
}

extension AddUserCategoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width*0.9
        let height = collectionView.frame.height*0.2
        
        return CGSize(width: width, height: height)
    }
}
