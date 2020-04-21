//
//  TopTabBarCVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

protocol PageIndexDelegate {
    func SelectMenuItem(pageIndex: Int)
}

class TopTabBarCVC: UICollectionViewCell {
    
    var delegate: PageIndexDelegate?
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var menuUnderBar: UIView!
    @IBOutlet weak var boundView: UIView!
    
    var collectionView: UICollectionView?

    override var isHighlighted: Bool {
        didSet {
            menuLabel.font = isHighlighted ? .boldSystemFont(ofSize: 25) : .boldSystemFont(ofSize: 15)

            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
                self.menuUnderBar.layoutIfNeeded()
                self.menuUnderBar.alpha = self.isSelected ? 1 : 0

            }, completion: nil)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            
            menuLabel.font = isSelected ? .boldSystemFont(ofSize: 17) : .boldSystemFont(ofSize: 15)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.menuUnderBar.layoutIfNeeded()
                self.menuUnderBar.alpha = self.isSelected ? 1 : 0
            }, completion: nil)
        }
    }

}
