//
//  CategoryList.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/06/02.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

// MARK: - CategoryList
struct CategoryList: Codable {
    let status: Int
    let message: String
    let data: [CategoryData]
}

// MARK: - Datum
struct CategoryData: Codable {
    let startColor, name: String
    let id: Int
    let endColor: String
}
