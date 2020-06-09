//
//  SearchTVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/06/09.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class SearchTVC: UITableViewCell {

    @IBOutlet weak var traceLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var underBar: UIView!
    
    var recode: String?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        deleteButton.tintColor = .lightGray
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        
    }
    
}
