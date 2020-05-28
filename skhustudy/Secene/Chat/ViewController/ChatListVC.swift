//
//  ChatListVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/05/27.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class ChatListVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),for: UIBarMetrics.default)
        let nib = UINib(nibName: "ChatListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChatRoomCell")
        
        // TODO: 채팅방 목록 가져오기.
        
    }
    
}

extension ChatListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomCell", for: indexPath) as! ChatListCell
        cell.profileImageView.image = UIImage(systemName: "person.fill")
        cell.idLabel.text = "From 000"
        cell.currentMessageLabel.text = "가장 최근에 온 메세지..."
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        // TODO: User 정보 넘겨주기
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
