//
//  ChatListVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/05/27.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import FirebaseFirestore
import SwiftKeychainWrapper

class ChatListVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let db = Firestore.firestore()
    var chatRooms = [ChatRoom]()
    private var messageListener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ChatListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChatRoomCell")
        observeMessage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        chatRooms = []
        getChatRooms()
        
    }
    
    private func observeMessage() {
        let ref = db.collection("ChatRooms")
        messageListener = ref.addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            //            self.chatRooms.removeAll()
            //            self.getChatRooms()
            snapshot.documentChanges.forEach { (change) in
                self.handleDocumentChange(change)
            }
        })
    }
    
    private func handleDocumentChange(_ change: DocumentChange) {
        let data = change.document
        
        guard let currentMessage = data["currentMessage"] as? String, let currentDate = data["currentDate"] as? String, let roomID = data.documentID as? String  else {
            return
        }
        
        for i in 0..<chatRooms.count {
            if chatRooms[i].roomID == roomID {
                chatRooms[i].currentMessage = currentMessage
                chatRooms[i].currentDate = currentDate
            }
        }
        
        self.chatRooms.sort { (room1, room2) -> Bool in
            let str1 = room1.currentDate
            let str2 = room2.currentDate
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy MMMM dd HH:mm:ss"
            
            let date1 = dateFormatter.date(from: str1)!
            let date2 = dateFormatter.date(from: str2)!
            
            
            return date1.compare(date2).rawValue == 1
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    private func getChatRooms() {
        // 채팅방 목록 가져오기.
        
        let ref = Firestore.firestore().collection("ChatRooms")
        ref.getDocuments { (snapshot, error) in
            if error != nil {
                //                print(error?.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else { return }
            
            for document in documents {
                let dic = document.data()
                let roomID = document.documentID
                let users = dic["users"] as! [String]
                let currentMessage = dic["currentMessage"] as? String
                var dateStr = dic["currentDate"] as! String
                
                for i in 0..<users.count {
                    let uid = users[i]
                    if uid ==  KeychainWrapper.standard.string(forKey: "userID")! { // 내가 포함된 채팅이라면
                        let recipientID = i == 0 ? users[i+1] : users[i-1]
                        
                        let chatRoom = ChatRoom(roomID: roomID,
                                                recipientID: recipientID,
                                                currentMessage: currentMessage,
                                                currentDate: dateStr)
                        
                        self.chatRooms.append(chatRoom)
                        break
                    }
                }
                
                self.chatRooms.sort { (room1, room2) -> Bool in
                    let str1 = room1.currentDate
                    let str2 = room2.currentDate
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy MMMM dd HH:mm:ss"
                    
                    let date1 = dateFormatter.date(from: str1)!
                    let date2 = dateFormatter.date(from: str2)!
                    
                    
                    return date1.compare(date2).rawValue == 1
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            
        }
        
    }
    
}

extension ChatListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if chatRooms.count == 0 {
            let emptyView = UIView(frame: CGRect(x: tableView.center.x, y: tableView.center.y, width: tableView.frame.width, height: tableView.frame.height))
            
            let label = UILabel()
            label.text = "채팅 목록이 없습니다."
            label.textColor = .systemGray
            label.sizeToFit()
            
            emptyView.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let constraints = [
                label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -150)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            tableView.backgroundView = emptyView
            tableView.separatorStyle = .none
            
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
        
        return chatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomCell", for: indexPath) as! ChatListCell
        
        db.collection("users").getDocuments { (snapshot, error) in
            if error != nil {
                return
            }
            guard let documents = snapshot?.documents else { return }
            for document in documents {
                let dic = document.data()
                let uid = dic["uid"] as! String
                if uid == self.chatRooms[indexPath.row].recipientID {
                    let imageURL = dic["imageURL"] as! String
                    let nickname = dic["nickname"] as! String
                    cell.profileImageView?.imageFromUrl(imageURL, defaultImgPath: "https://t1.daumcdn.net/cfile/tistory/2513B53E55DB206927")
                    cell.idLabel.text = nickname
                    cell.currentMessageLabel.text = self.chatRooms[indexPath.row].currentMessage ?? ""
                    
                    // 날짜 표시 로직
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy MMMM dd HH:mm:ss"
                    var dateStr = self.chatRooms[indexPath.row].currentDate
                    if let recent = dateFormatter.date(from: dateStr){
                        if Calendar.current.isDateInToday(recent) { // 시간 표시
                            for _ in 0..<13 {
                                dateStr.removeFirst()
                            }
                            for _ in 0..<3 {
                                dateStr.removeLast()
                            }
                        } else if Calendar.current.isDateInYesterday(recent) {
                            dateStr = "어제"
                        } else { // mm-dd
                            for _ in 0..<5 {
                                dateStr.removeFirst()
                            }
                            for _ in 0..<9 {
                                dateStr.removeLast()
                            }
                        }
                        
                    }
                    cell.dateLabel.text = dateStr
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! ChatListCell
        
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.roomID = chatRooms[indexPath.row].roomID
        vc.recipientID = chatRooms[indexPath.row].recipientID
        vc.recipientNickname = cell.idLabel.text!
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
