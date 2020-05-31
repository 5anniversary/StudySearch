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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? 400
        message = (try? values.decode(String.self, forKey: .message)) ?? "StudyInfo model의 JSON Decode에 실패하였습니다"
        data = (try? values.decode([StudyInfoData].self, forKey: .data)) ?? [StudyInfoData.init(id: 0, name: "", content: "", userLimit: 0, isDate: false, startDate: "", endDate: "", category: "", location: "", image: "", chiefUser: StudyUser.init(id: 0, userID: "", name: "", image: "")/*, studyUser: [StudyUser.init(id: 0, userID: "", name: "", image: "")]*/, wantUser: [StudyUser.init(id: 0, userID: "", name: "", image: "")], isFine: false, isEnd: true, createdAt: "", fine: Fine.init(tardy: 0, attendance: 0, assignment: 0))]
    }
}

// MARK: - StudyInfoData
struct StudyInfoData: Codable {
    let id: Int
    let name, content: String
    let userLimit: Int
    let isDate: Bool
    let startDate, endDate, category, location: String
    let image: String
    let chiefUser: StudyUser
    let /*studyUser, */wantUser: [StudyUser] // 샘플 데이터에 studyUser 항목이 없는 경우
    let isFine, isEnd: Bool
    let createdAt: String // Date형일 시 Decode 오류 발생, String으로 처리
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
