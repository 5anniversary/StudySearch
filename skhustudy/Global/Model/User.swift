//
//  User.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/20.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let name: String
    let email: String
    let image: String
    let content: String
    let sex: String
    let age: Int
    let category: [String]
    let isStudy: Studying
    let endStudy: Studying
    
    init?(dictionary: [String:Any]){
        self.uid = dictionary["uid"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.content = dictionary["content"] as? String ?? ""
        self.sex = dictionary["sex"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.category = dictionary["category"] as? [String] ?? []
        self.isStudy = dictionary["isStudy"] as? Studying ?? Studying.init(id: 0,
                                                                           name: "",
                                                                           category: "",
                                                                           image: "",
                                                                           isEnd: false)
        self.endStudy = dictionary["endStudy"] as? Studying ?? Studying.init(id: 0,
                                                                             name: "",
                                                                             category: "",
                                                                             image: "",
                                                                             isEnd: false)
    }
    
}

struct Studying {
    let id: Int
    let name: String
    let category: String
    let image: String
    let isEnd: Bool
}
