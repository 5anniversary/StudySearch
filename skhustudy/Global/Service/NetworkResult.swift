//
//  NetworkResult.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/12.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation

enum NetworkResult<T>{
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
