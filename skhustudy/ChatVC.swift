//
//  ChatVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/05/27.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import FirebaseFirestore
import SwiftKeychainWrapper

class ChatVC: UIViewController {
    
    fileprivate let cellID = "id"
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    var roomID: String?
    var recipientID: String?
    var recipientNickname: String?
    private var messageListener: ListenerRegistration?
    
    let db = Firestore.firestore()
    
    var chatMessages = [ChatModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        addKeyboardNotification()
        tableView.keyboardDismissMode = .onDrag
        messageTextView.delegate = self
        messageTextView.layer.cornerRadius = 12
        messageTextView.showsVerticalScrollIndicator = false
        
        // Observer 등록
        if let roomID = roomID { // Chat List에서 들어왔을 때
            observeMessage(roomID)
        }
        
        if let recipientID = recipientID {
            self.title = recipientID
        }
        
    }
    
    private func observeMessage(_ roomID: String) {
        let reference = db.collection(["ChatRooms", roomID, "messages"].joined(separator: "/"))
        messageListener = reference.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { (chage) in
                self.handleDocumentChange(chage)
            }
            
            
        }
    }
    
    private func handleDocumentChange(_ change: DocumentChange) {
        let data = change.document
        
        let text = data["text"] as! String
        let senderID = data["senderID"] as! String
        let isIncoming = senderID == KeychainWrapper.standard.string(forKey: "userID")! ? false : true
        let message = ChatModel(text: text, isIncoming: isIncoming)
        
        chatMessages.append(message)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.chatMessages.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        bottomConstraint.constant = keyboardFrame.height - 16
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        bottomConstraint.constant = 0
    }
    
    @IBAction func didTapSendButton(_ sender: Any) {
        guard let text = messageTextView.text, !text.isEmpty else { return }
        messageTextView.text = ""
        
        // DB에 새로운 메세지 저장 후 reload
        if roomID == nil { // 첫 생성
            if let recipientID = recipientID {
                roomID = db.collection("ChatRooms").addDocument(data: [
                    "users": [recipientID, KeychainWrapper.standard.string(forKey: "userID")!]
                ]).documentID
                observeMessage(roomID!)
            }
        }
        
        db.collection("ChatRooms/\(roomID!)/messages").addDocument(data: [
            "date": "날짜",
            "senderID": KeychainWrapper.standard.string(forKey: "userID")!,
            "text": text,
        ])
        
        let indexPath = IndexPath(row: self.chatMessages.count-1, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    
        messageTextView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = 33.0
            }
        }
    }
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatCell
        
        let chatMessage = chatMessages[indexPath.row]
        cell.chatMessage = chatMessage
        
        return cell
    }
}

extension ChatVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                if estimatedSize.height < 80 {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}
