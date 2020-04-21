//
//  Study.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/20.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

struct Study {
    let id: Int
    let name: String
    let attendanceFine: Int
    let tardyFine: Int
    let assignmentFine: Int
    let content: String
    let chiefUserID : StudyUser
    let category: String
    let users: StudyUser
    let chapter: Chapter
    
    init?(dictionary: [String:Any]){
        self.id = dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.attendanceFine = dictionary["attendanceFine"] as? Int ?? 0
        self.tardyFine = dictionary["tardyFine"] as? Int ?? 0
        self.assignmentFine = dictionary["assignmentFine"] as? Int ?? 0
        self.content = dictionary["content"] as? String ?? ""
        self.chiefUserID = dictionary["chiefUserID"] as? StudyUser ?? StudyUser.init(name: "",
                                                                                     uid: "",
                                                                                     image: "")
        self.category = dictionary["category"] as? String ?? ""
        self.users = dictionary["users"] as? StudyUser ?? StudyUser.init(name: "",
                                                                         uid: "",
                                                                         image: "")
        self.chapter = dictionary["chapter"] as? Chapter ?? Chapter.init(number: 0,
                                                                         content: "",
                                                                         date: Date(),
                                                                         place: "",
                                                                         attendance: 0,
                                                                         isAssignment: false)
    }
    
}

struct Chapter {
    let number: Int
    let content: String
    let date: Date
    let place: String
    let attendance: Int
    let isAssignment: Bool
}

struct StudyUser {
    let name: String
    let uid: String
    let image: String
}
