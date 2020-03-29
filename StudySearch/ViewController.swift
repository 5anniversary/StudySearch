//
//  ViewController.swift
//  StudySearch
//
//  Created by Junhyeon on 2020/03/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "테스트테스트테스트"
        label.font = .boldSystemFont(ofSize: 30)
        label.frame = CGRect(x: 10, y: 10, width: 300, height: 100)
        view.addSubview(label)
    }


}

