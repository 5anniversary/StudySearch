//
//  SettingCell.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class SettingCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 이게 되네;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    func setupViews() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        //        addConstraint(NSLayoutConstraint(item: superview ?? 0,
//                                         attribute: .centerX,
//                                         relatedBy: .equal,
//                                         toItem: safeAreaLayoutGuide,
//                                         attribute: .centerY,
//                                         multiplier: 1,
//                                         constant: 0))
    }
    
    let nameLabel: UILabel = {
          let label = UILabel()
          label.text = "Setting"
          label.font = UIFont.systemFont(ofSize: 13)
          return label
      }()
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
        }
    }
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
        
    

}
