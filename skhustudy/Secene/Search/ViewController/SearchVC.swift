//
//  SearchVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/06/09.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit
import CoreData

class SearchVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTV: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    let headerView = UIView()
    let headerLabel = UIButton().then{
        $0.setTitle("이전 검색", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = Font.lightLabel
    }
    let headerDeleteButton = UIButton().then {
        $0.setTitle("전체 삭제", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = Font.lightLabel
    }
    
    var recodeMemory : [String] = []
    var recodeObject: [NSManagedObject] = []
    let con = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let context = self.getRecode()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Recode")
        
        let sortDescriptor = NSSortDescriptor(key: "time", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do{
            recodeObject = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
        
        for i in 0..<recodeObject.count {
            recodeMemory.append(recodeObject[i].value(forKey: "recode") as! String)
        }
        
        set()
    }
    
    func set(){
        searchTextField.delegate = self
        self.searchTV.separatorStyle = .none
        searchTV.delegate = self
        searchTV.dataSource = self
        self.searchTV.tableFooterView = nil

        searchButton.isHidden = true
        searchButton.tintColor = .signatureColor
        searchTextField.addBorder(.bottom,
                                  color: .signatureColor,
                                  thickness: 1)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        searchTextField.becomeFirstResponder()
        searchTV.register(UINib(nibName: "SearchTVC", bundle: nil), forCellReuseIdentifier: "SearchTVC")
        searchButton.addTarget(self,
                               action: #selector(search),
                               for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func getRecode() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func save(_ inputRecode: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext =
          appDelegate.persistentContainer.viewContext

        // 2
        let entity =
          NSEntityDescription.entity(forEntityName: "Recode",
                                     in: managedContext)!

        let recode = NSManagedObject(entity: entity,
                                     insertInto: managedContext)

        // 3
        recode.setValue(inputRecode, forKeyPath: "recode")
        recode.setValue(Date(), forKey: "time")
        
        // 4
        do {
          try managedContext.save()
          recodeObject.append(recode)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }

        
    }
    
    @objc func search(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultVC") as! SearchResultVC
            
        let text = searchTextField.text ?? ""
        save(text)
        vc.searchResult = text

        recodeMemory.insert(text, at: 0)
        searchTV.reloadData()
        
        searchTextField.text = ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchInList(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultVC") as! SearchResultVC
        let text: String = searchText
        
        vc.searchResult = text
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
            make.top.equalTo(headerView.snp.top).offset(5)
        }
        
        headerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(headerView.snp.leading)
            make.top.equalTo(headerView.snp.top).offset(5)
        }
        
        headerDeleteButton.addTarget(self, action: #selector(deleteAllRecords), for: .touchUpInside)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let postItems = recodeMemory.count
                
        if postItems == 0 {
            searchTV.setEmptyView(title: "", message: "검색 기록이 없습니다.")
        } else {
            searchTV.restore()
        }

        return postItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTVC",
                                                 for: indexPath) as! SearchTVC
        let recoding = recodeMemory[indexPath.row]
        
        cell.traceLabel.text = recoding
        cell.deleteButton.isHidden = true
        
        return cell
    }    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: "SearchTVC",
                                          for: indexPath) as! SearchTVC

        searchText = recodeMemory[indexPath.row]
        self.searchInList()
        self.searchTV.reloadData()
    }
    
    @objc func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Recode")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
        
            try context.execute(deleteRequest)
            try context.save()
        
        } catch {
        
            print ("There was an error")
        
        }
        
        recodeMemory = []
        
        searchTV.reloadData()
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

