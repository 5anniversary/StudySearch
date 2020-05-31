//
//  StudyChapterList.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/31.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

// MARK: - StudyChapterList
struct StudyChapterList: Codable {
    let status: Int
    let message: String
    let data: [ChapterListData]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? 400
        message = (try? values.decode(String.self, forKey: .message)) ?? "StudyChapterList model의 JSON Decode에 실패하였습니다"
        data = (try? values.decode([ChapterListData].self, forKey: .data)) ?? []
    }
}

// MARK: - Datum
struct ChapterListData: Codable {
    let date: String
    let id: Int
    let content, place: String
    let createdAt: String
    let studyID: Int
}
