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
    var category: [String] = ["전체"]
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

//        res()
        
        navigationItem.title = "Study Together"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 네비바 border 삭제
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
     
//        getCategoryListService(completionHandler: {()-> Void in
//            self.collectionView.reloadData()
//        })
        fetchCategory()
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
        db.collection("category").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let test = document.data()
                    var count = 1
                    test.forEach {
                        if count < 3 {
                            self.category.append($0.key)
                        }
                        count += 1
                    }
                    self.collectionView.reloadData()
                }
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
        
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopTabBarCVC",
                                                      for: indexPath) as! TopTabBarCVC
        cell.menuLabel.text = category[indexPath.row]
                
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

// MARK: - Study Chapter List Service

extension MainVC {
    
    func fetchCategory() {
        UserService.shared.getCategory { result in
            switch result {
            case .success(let data):
                let responseCategoryList = data as! [Category]
                
                for category in responseCategoryList {
                    self.category.append(category.name)
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
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
    
    func getCategoryListService(completionHandler: @escaping () -> Void) {
        StudyService.shared.getCategoryList() { result in
        
            switch result {
                case .success(let res):
                    let responseCategoryList = res as! CategoryList
                    
                    switch responseCategoryList.status {
                    case 200:
                        for category in responseCategoryList.data {
                            self.category.append(category.name)
                        }
                        
                        completionHandler()
                        
                    case 400, 406, 411, 500, 420, 421, 422, 423:
                        self.simpleAlert(title: responseCategoryList.message, message: "")
                        
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
