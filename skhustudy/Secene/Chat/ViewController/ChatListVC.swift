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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),for: UIBarMetrics.default)
        let nib = UINib(nibName: "ChatListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChatRoomCell")
        getChatRooms()
    }
    
    private func getChatRooms() {
        // 채팅방 목록 가져오기.
        let ref = Firestore.firestore().collection("ChatRooms")
        
        ref.getDocuments { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else { return }
            
            for document in documents {
                let dic = document.data()
                let roomID = document.documentID
                let users = dic["users"] as! [String]
                for i in 0..<users.count {
                    let uid = users[i]
                    if uid ==  KeychainWrapper.standard.string(forKey: "userID")! {
                        let recipientID = i == 0 ? users[i+1] : users[i-1]
                        let chatRoom = ChatRoom(roomID: roomID, recipientID: recipientID)
                        self.chatRooms.append(chatRoom)
                        break
                    }
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
                }
            }
        }
        
        cell.currentMessageLabel.text = "가장 최근에 온 메세지..."
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.roomID = chatRooms[indexPath.row].roomID
        vc.recipientID = chatRooms[indexPath.row].recipientID
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
