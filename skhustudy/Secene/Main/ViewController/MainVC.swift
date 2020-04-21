//
//  MainVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Firebase
import SnapKit

class MainVC: UIViewController {
    
    //MARK: - Firebase
    // firebase 데이터베이스를 사용하기 위한 인스턴스 생성
    let db = Firestore.firestore()
    
    // MARK: - UI components
    var pageInstance: PageVC?
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables and Properties
    private var viewControllers = [AllVC(), HashOneVC(), HashTwoVC(), HashThreeVC()]
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
                
        setFirstIndexIsSelected()
        setNavigationBarTransperant()
        setupNavBarButtons()
        
        add()
        res()
        
        
    }
    
    func setNavigationBarTransperant() {
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 네비바 border 삭제
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("prepare")
        if segue.identifier == "PageSegue" {
            pageInstance = segue.destination as? PageVC
            pageInstance?.pageDelegate = self
        }
    }
    
    
    func setFirstIndexIsSelected() {
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .bottom)
        // 0번째 Index로
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    func setupNavBarButtons() {
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItem = moreButton
    }
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func add(){
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func res(){
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print(querySnapshot?.documents)
                for document in querySnapshot!.documents {
                    print("1111: \(document.documentID) => \(document.data())")
                    print(document)
                    
                }
            }
        }
        
    }
}

extension MainVC : PageIndexDelegate {
    func SelectMenuItem(pageIndex: Int) {
        let indexPath = IndexPath(item: pageIndex, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
    }
}

extension MainVC : UICollectionViewDelegate { }

extension MainVC : UICollectionViewDelegateFlowLayout { }

extension MainVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopTabBarCVC", for: indexPath) as! TopTabBarCVC
        
        cell.menuLabel.text = TopBarItem.substring[indexPath.row]
        
        if (indexPath.item == 0) {
            cell.menuUnderBar.alpha = 1
        } else {
            cell.menuUnderBar.alpha = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        print(indexPath.item)
        let cvIndexPath = indexPath.item
        guard let pageInstance = pageInstance else { return }
        print(pageInstance.getViewControllerAtIndex(index: cvIndexPath) as Any)
        
        pageInstance.setViewControllers([pageInstance.VCArray[cvIndexPath]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width / 4
        //        let height = width * (40 / 375)
        
        return CGSize(width: width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width )
        
        print (index)
    }
    
    func scrollToItem(menuIndex: Int) {
        
        let indexPath = IndexPath(item: menuIndex, section: 0)
        
        print(indexPath)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
