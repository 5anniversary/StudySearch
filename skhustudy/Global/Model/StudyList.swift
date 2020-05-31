//
//  StudyList.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/31.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

// MARK: - StudyList
struct StudyList: Codable {
    let status: Int
    let message: String
    let data: [StudyListData]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? 400
        message = (try? values.decode(String.self, forKey: .message)) ?? "StudyList model의 JSON Decode에 실패하였습니다"
        data = (try? values.decode([StudyListData].self, forKey: .data)) ?? [StudyListData.init(location: "", content: "", userLimit: 0, id: 0, isDate: false, startDate: "", endDate: "", category: "", isFine: false, image: "", isEnd: true, createdAt: "", name: "")]
    }
}

// MARK: - Datum
struct StudyListData: Codable {
    let location, content: String
    let userLimit, id: Int
    let isDate: Bool
    let startDate, endDate, category: String
    let isFine: Bool
    let image: String
    let isEnd: Bool
    let createdAt: String
    let name: String
}
