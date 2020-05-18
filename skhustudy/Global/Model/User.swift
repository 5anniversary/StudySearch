//
//  User.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/20.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

// MARK: - User
struct User: Codable {
    let status: Int
    let message: String
    let data: UserData
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? 400
        message = (try? values.decode(String.self, forKey: .message)) ?? "User model의 JSON Decode에 실패하였습니다"
        data = (try? values.decode(UserData.self, forKey: .data)) ?? UserData.init(userID: "", location: "", id: 0, age: 0, picLink: "", sex: 0, nickName: "", userCategory: [""])
    }
    
}

// MARK: - DataClass
struct UserData: Codable {
    let userID, location: String
    let id, age: Int
    let picLink: String
    let sex: Int
    let nickName: String
    let userCategory: [String]
}
