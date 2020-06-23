//
//  ChapterPenaltyStatusList.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

// MARK: - ChapterPenaltyStatusList
struct ChapterPenaltyStatusList: Codable {
    let status: Int
    let message: String
    let data: [ChapterPenaltyData]
}

// MARK: - Datum
struct ChapterPenaltyData: Codable {
    let studyID, chapterID: Int
    let tardy, assignment, attendance: [PenaltyStatus]
}

// MARK: - Assignment
struct PenaltyStatus: Codable {
    let name: String
    let isCheck: Int
}
