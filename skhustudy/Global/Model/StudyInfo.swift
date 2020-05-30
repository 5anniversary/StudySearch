//
//  StudyInfo.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

// MARK: - StudyInfo
struct StudyInfo: Codable {
    let status: Int
    let message: String
    let data: [StudyInfoData]
}

// MARK: - StudyInfoData
struct StudyInfoData: Codable {
    let id: Int
    let name, content: String
    let userLimit: Int
    let category, location: String
    let image: String
    let chiefUser: StudyUser
    let studyUser, wantUser: [StudyUser]
    let isFine, isEnd: Bool
    let createdAt: Date
    let fine: Fine
}

// MARK: - StudyUser
struct StudyUser: Codable {
    var id: Int
    var userID, name: String
    var image: String
}

// MARK: - Fine
struct Fine: Codable {
    let tardy, attendance, assignment: Int
}
