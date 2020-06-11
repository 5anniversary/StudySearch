//
//  PageCVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/06/10.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class PageCVC: UICollectionViewCell {
    static let reuseIdentifier = "TabPageCell"
//    let tableViewInCVC = UITableView()
    func setColor(index: Int){

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.addSubview(tableViewInCVC)
        
//        tableViewInCVC.snp.makeConstraints { (make) in
//            make.top.equalTo(contentView)
//            make.leading.equalTo(contentView)
//            make.trailing.equalTo(contentView)
//            make.bottom.equalTo(contentView)
//        }
//        tableViewInCVC.register(StudyTVC.self, forCellReuseIdentifier: "StudyTVC")
//
//        tableViewInCVC.bounces = false
//        tableViewInCVC.isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func offScroll(){
//        tableViewInCVC.isScrollEnabled = false
//    }
//
//    func onScroll(){
//        tableViewInCVC.isScrollEnabled = false
//    }
}

//extension PageCVC: UITableViewDelegate { }
//extension PageCVC: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTVC",
//                                                 for: indexPath) as! StudyTVC
//
//        print(#function)
//        cell.addContentView()
//
//        return cell
//    }
//
//
//}
