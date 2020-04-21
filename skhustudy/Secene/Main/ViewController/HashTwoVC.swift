//
//  HashTwoVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/17.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class HashTwoVC: UIViewController {
    
    // MARK: - UI components
    
    let tableView = UITableView().then {_ in
        
    }
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        self.view.backgroundColor = .red
        
    }
    
    // MARK: - Helper
    func setTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HashTwoTVC")
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - UITableView
extension HashTwoVC : UITableViewDelegate { }

extension HashTwoVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HashTwoTVC",
                                                 for: indexPath) as UITableViewCell
        
        return cell
    }
}
