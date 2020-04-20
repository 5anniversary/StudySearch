//
//  MainVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Firebase
import Pageboy
import SnapKit
import Tabman

class MainVC: TabmanViewController {
    
    //MARK: - Firebase
    // firebase 데이터베이스를 사용하기 위한 인스턴스 생성
    let db = Firestore.firestore()
    
    // MARK: - UI components
    let bar = TMBar.ButtonBar()
    
    // MARK: - Variables and Properties
    private var viewControllers = [AllVC(), HashOneVC(), HashTwoVC(), HashThreeVC()]
        
    // MARK: - dummy data
    
    var hashtag: [String] = ["#it", "#qwe", "#123"]
    var cnt = 0
    var title1 : [String] = ["전체", "#", "#", "#"]

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        bar.layout.transitionStyle = .snap
        
        addBar(bar, dataSource: self, at: .top)
        setting()
        
//        add()
        res()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 네비바 border 삭제
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    func setting(){
        let view = UIView()
        view.backgroundColor = .white

        bar.backgroundView.style = .custom(view: view)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 10, bottom: 0.0, right: 10.0)
        bar.layout.contentMode = .fit
        bar.indicator.tintColor = .orange
        bar.buttons.customize { (button) in
            button.selectedTintColor = .orange
        }
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

extension MainVC : PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title2 = title1[index]
        return TMBarItem(title: title2)
    }
}

