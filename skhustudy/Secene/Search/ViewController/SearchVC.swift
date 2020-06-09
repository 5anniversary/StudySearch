//
//  SearchVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/06/09.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTabelView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    let headerView = UIView()
    let headerLabel = UILabel().then{
        $0.text = "이전 검색"
        $0.textColor = .lightGray
        $0.font = Font.lightLabel
    }
    let headerDeleteButton = UIButton().then {
        $0.setTitle("전체 삭제", for: .normal)
        $0.tintColor = .lightGray
        $0.titleLabel?.font = Font.lightLabel
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set()
    }
    
    func set(){
        searchButton.isHidden = true
        searchButton.tintColor = .signatureColor
        searchTabelView.addBorder(.bottom,
                                  color: .signatureColor,
                                  thickness: 1)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        searchTextField.becomeFirstResponder()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

    @objc func search(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultVC") as! SearchResultVC
        
        vc.searchResult = searchTextField.text ?? ""
        recodeData.recode.append(searchTextField.text ?? "")
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension SearchVC: UITableViewDelegate { }
extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        self.headerView.addSubview(headerDeleteButton)
        self.headerView.addSubview(headerLabel)
        
        headerDeleteButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(headerView.snp.trailing)
            make.top.equalTo(headerView.snp.top).offset(15)
        }
        headerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(headerView.snp.leading)
            make.top.equalTo(headerView.snp.top).offset(15)
        }

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 19
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTVC",
                                                 for: indexPath) as! SearchTVC
        
        
        return cell
    }
    
    @objc func delete(){
        
    }
    
    
}

extension SearchVC : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 입력된 빈칸 감지하기
        var str = textField.text
        str = str?.replacingOccurrences(of: " ", with: "")
        
        if str?.count == 0 {
            searchButton.isHidden = true
        } else {
            searchButton.isHidden = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 입력된 빈칸 감지하기
        var str = textField.text
        str = str?.replacingOccurrences(of: " ", with: "")
        
        if str?.count != 0 {
            search()
            searchTextField.resignFirstResponder()
        }
        return true
    }
    
}

