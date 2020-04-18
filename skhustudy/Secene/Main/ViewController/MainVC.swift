//
//  MainVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase
import Pageboy
import SnapKit
import Tabman

class MainVC: TabmanViewController {
    
    //MARK: - Firebase
    // firebase 데이터베이스를 사용하기 위한 인스턴스 생성
    var ref: DatabaseReference!

    // MARK: - UI components
    let bar = TMBar.ButtonBar()
    
    // MARK: - Variables and Properties
    private var viewControllers = [AllVC(), HashOneVC(), HashTwoVC(), HashThreeVC()]
    
    var content : [[String]] = Array(repeating: Array(repeating: "", count: 0), count: 0)
    var link : [[String]] = Array(repeating: Array(repeating: "", count: 0), count: 0)
    var hashtag: [String] = ["#it", "#qwe", "#123"]
    var cnt = 0
    var title1 : [String] = ["전체", "", "", ""]
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        bar.layout.transitionStyle = .snap
        
        ref = Database.database().reference()
        
        addBar(bar, dataSource: self, at: .top)
        setting()
        
        ref.child("hashtag").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            dump(snapshot)
            let value = snapshot.value as! [String]

            for hashtag in value {
                self.title1[self.cnt] = hashtag
                self.cnt += 1
                self.barItem(for: self.bar, at: 0)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
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

