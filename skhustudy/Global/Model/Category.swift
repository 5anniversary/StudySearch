//
//  Category.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/20.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

struct Category {
    let name: String
    let id: Int

    init?(dictionary: [String:Any]){
        self.name = dictionary["name"] as? String ?? ""
        self.id = dictionary["id"] as? Int ?? 0
    }
}
