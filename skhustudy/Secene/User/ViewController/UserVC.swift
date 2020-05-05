//
//  UserVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/14.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import SnapKit
import Then

class UserVC: UIViewController {
    
    // MARK: - UI components
    
    @IBOutlet var userTV: UITableView!
    
    // MARK: - Variables and Properties
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTV.dataSource = self
        self.userTV.delegate = self
        
        // Register the custom header view
        userTV.register(UINib(nibName: "UserHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "UserHeaderView")
        // Register the StudyCell from Main tab
        userTV.register(UINib(nibName: "StudyTVC", bundle: nil), forCellReuseIdentifier: "StudyTVC")
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    // MARK: - Helper
    
}

    // MARK: - TableView

extension UserVC: UITableViewDelegate { }
extension UserVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UserHeaderView") as? UserHeaderView
        
        headerView?.initUserInfo()
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTVC", for: indexPath) as! StudyTVC
        
        cell.selectionStyle = .none
        cell.initCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let studyDetailSB = UIStoryboard(name: "StudyDetail", bundle: nil)
        let showStudyDetailVC = studyDetailSB.instantiateViewController(withIdentifier: "StudyDetail") as! StudyDetailVC
        
        self.navigationController?.pushViewController(showStudyDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
