//
//  MainVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Firebase
import FirebaseFirestore
import SnapKit

class MainVC: UIViewController {
    
    //MARK: - Firebase
    // firebase 데이터베이스를 사용하기 위한 인스턴스 생성
    let db = Firestore.firestore()
    
    // MARK: - UI components
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables and Properties
    private var viewControllers = [AllVC(), HashOneVC(), HashTwoVC(), HashThreeVC()]
    var delegate: PageIndexDelegate?
    var pageInstance: PageVC?
    var category: [String]?
    var data: Category?
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
                
        setFirstIndexIsSelected()
        setNavigationBarTransperant()
//        setupNavBarButtons()
        res()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 네비바 border 삭제
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PageSegue" {
            pageInstance = segue.destination as? PageVC
            pageInstance?.pageDelegate = self
            print(pageInstance ?? "")
        }
    }
    
    func setNavigationBarTransperant() {
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
    
//    func setupNavBarButtons() {
//        let moreButton = UIBarButtonItem(image: UIImage(named: "testUserImage")?.withRenderingMode(.alwaysOriginal),
//                                         style: .plain,
//                                         target: self,
//                                         action: #selector(handleMore))
//
//        navigationItem.rightBarButtonItem = moreButton
//    }
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
//    func add(){
//        var ref: DocumentReference? = nil
//        ref = db.collection("users").addDocument(data: [
//            "first": "Ada",
//            "last": "Lovelace",
//            "born": 1815
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
//    }
    

//
    func res(){
//        var ref: DocumentReference? = nil
        db.collection("category").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.data = Category(dictionary: document.data())
                    dump(self.data)
                }
//                if let setCategory = self.data {
//                    print(setCategory)
//                }

            }
        }

    }
}

extension MainVC : PageIndexDelegate {
    func SelectMenuItem(pageIndex: Int) {
        let indexPath = IndexPath(item: pageIndex, section: 0)
        collectionView.selectItem(at: indexPath,
                                  animated: true,
                                  scrollPosition: .centeredHorizontally)
    }
}

extension MainVC : UICollectionViewDelegate { }
extension MainVC : UICollectionViewDelegateFlowLayout { }
extension MainVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopTabBarCVC",
                                                      for: indexPath) as! TopTabBarCVC
        cell.menuLabel.text = TopBarItem.substring[indexPath.item]
        
//        if indexPath.row == 0 {
//            cell.backgroundColor = .black
//        } else if indexPath.row == 1 {
//            cell.backgroundColor = .red
//        } else if indexPath.row == 2 {
//            cell.backgroundColor = .blue
//        } else if indexPath.row == 3 {
//            cell.backgroundColor = .orange
//        }

        if (indexPath.item == 0) {
            cell.menuUnderBar.alpha = 1
        } else {
            cell.menuUnderBar.alpha = 0
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let cvIndexPath = indexPath.item
        guard let pageInstance = pageInstance else { return }
        
        pageInstance.setViewControllers([pageInstance.VCArray[cvIndexPath]],
                                        direction: UIPageViewController.NavigationDirection.forward,
                                        animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3.5
        
        return CGSize(width: width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }
        
    func scrollToItem(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)

        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
