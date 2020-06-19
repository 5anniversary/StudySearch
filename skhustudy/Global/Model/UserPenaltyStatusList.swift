//
//  StudyPenaltyInfo.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/19.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

// MARK: - StudyPenaltyInfo
struct UserPenaltyStatusList: Codable {
    let status: Int
    let message: String
    let data: [UserPenaltyStatusListData]
}

// MARK: - Datum
struct UserPenaltyStatusListData: Codable {
    let userID: String
    let assignment, attendance, id: Int
    let image: String
    let tardy, studyID: Int
    let name: String
}
