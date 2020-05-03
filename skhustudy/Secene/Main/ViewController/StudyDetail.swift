//
//  StudyDetail.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/04/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then
import SnapKit

class StudyDetailVC: UIViewController {
    
    // MARK: - UI components
    
    @IBOutlet var studyWeeksTV: UITableView!
    
    // MARK: - Variables and Properties
    
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studyWeeksTV.dataSource = self
        studyWeeksTV.delegate = self
        
        // Register the custom header view
        studyWeeksTV.register(UINib(nibName: "StudyDetailHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "StudyDetailHeaderView")
        // Register the custom cell
        studyWeeksTV.register(UINib(nibName: "StudyTVC", bundle: nil), forCellReuseIdentifier: "StudyTVC")
        // Register the custom footer view
        studyWeeksTV.register(UINib(nibName: "StudyDetailFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "StudyDetailFooterView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
 
    
    // MARK: - Helper
    
}

// MARK: - UITableView

extension StudyDetailVC : UITableViewDelegate { }

extension StudyDetailVC : UITableViewDataSource {
    
    // Table HeaderView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StudyDetailHeaderView") as? StudyDetailHeaderView
        
        headerView?.initStudyDetail()
        
        return headerView
    }

    // Table Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTVC", for: indexPath) as! StudyTVC
        
        cell.selectionStyle = .none
        cell.initCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let weekDetailSB = UIStoryboard(name: "WeekDetail", bundle: nil)
        let showWeekDetailVC = weekDetailSB.instantiateViewController(withIdentifier: "WeekDetail") as! WeekDetailVC
        
        self.navigationController?.pushViewController(showWeekDetailVC, animated: true)
    }

    // Table FooterView
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StudyDetailFooterView") as? StudyDetailFooterView
        
        footerView?.initStudyDetail()
        footerView?.studyDetailVC = self
        
        return footerView
    }
}
