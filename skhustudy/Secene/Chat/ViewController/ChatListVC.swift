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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func observeMessage() {
        let ref = db.collection("ChatRooms")
        messageListener = ref.addSnapshotListener({ (querySnapshot, error) in
            guard let _ = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            self.chatRooms.removeAll()
            self.getChatRooms()
        })
        
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
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy MMMM dd HH:mm:ss"
                
                if let recent = dateFormatter.date(from: dateStr){
                    if Calendar.current.isDateInToday(recent) {
                        for _ in 0..<13 {
                            dateStr.removeFirst()
                        }
                        for _ in 0..<3 {
                            dateStr.removeLast()
                        }
                    } else if Calendar.current.isDateInYesterday(recent) {
                        dateStr = "어제"
                    } else {
                        for _ in 0..<5 {
                            dateStr.removeFirst()
                        }
                        for _ in 0..<9 {
                            dateStr.removeLast()
                        }
                    }
                    
                }
                
                for i in 0..<users.count {
                    let uid = users[i]
                    if uid ==  KeychainWrapper.standard.string(forKey: "userID")! {
                        let recipientID = i == 0 ? users[i+1] : users[i-1]
                        
                        let chatRoom = ChatRoom(roomID: roomID, recipientID: recipientID, currentMessage: currentMessage,
                                                currentDate: dateStr)
                        
                        self.chatRooms.append(chatRoom)
                        break
                    }
                }
                
                self.chatRooms.sort { $0.currentDate > $1.currentDate }
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
            tableView.setEmptyView(title: "", message: "채팅이 없습니다")
            
        } else {
            tableView.restore()
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
                    cell.profileImageView?.imageFromUrl(imageURL, defaultImgPath: "")
                    cell.idLabel.text = nickname
                    cell.currentMessageLabel.text = self.chatRooms[indexPath.row].currentMessage ?? ""
                    cell.dateLabel.text = self.chatRooms[indexPath.row].currentDate
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
