//
//  Response.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/17.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let status: Int
    let data: DataClass
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? 400
        data = (try? values.decode(DataClass.self, forKey: .data)) ?? DataClass.init(accessToken: "")
        message = (try? values.decode(String.self, forKey: .message)) ?? "Response model의 JSON Decode에 실패하였습니다"
    }

}

// MARK: - DataClass
struct DataClass: Codable {
    let accessToken: String
}
