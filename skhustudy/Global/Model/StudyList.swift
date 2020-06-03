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
        data = (try? values.decode([StudyListData].self, forKey: .data)) ?? []
    }
}

// MARK: - Datum
struct StudyListData: Codable {
    let location, content: String
    let userLimit, id: Int
//    let isDate: Bool
    let /*startDate, endDate,*/ category: String
    let isFine: Bool
    let image: String
    let isEnd: Bool
//    let createdAt: String
    let name: String
    
    // 위, 아래 주석 처리 항목들은 '메인 화면'에서의 스터디 정보와 '사용자 탭'에서의 스터디 정보을 JSON Decode하는 과정에서 받아와지는 데이터 항목의 차이에 대한 오류를 방지하기 위해 처리
    // 서로 공통된 항목만 받아와야 data에 잘 담겨짐
    
//    let userID: String
//    let studyID: Int
}
