//
//  ChatListCell.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/05/28.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class ChatListCell: UITableViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var currentMessageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.tintColor = UIColor.lightGray
        profileImageView.setRounded(radius: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
