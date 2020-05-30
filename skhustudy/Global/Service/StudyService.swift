//
//  StudyService.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

struct StudyService {
    
    private init() {}
    
    static let shared = StudyService()
    
    // MARK: - 스터디 만들기
    
    func createStudy(token: String, name: String, image: String, location: String, content: String, userLimit: Int, isFine: Bool, isEnd: Bool, chiefUser: StudyUser, category: String, fine: Fine, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.CreateStudy
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        let body : Parameters = [
            "token": token,
            "name": name,
            "image": image,
            "location": location,
            "content": content,
            "userLimit": userLimit,
            "isFine": isFine,
            "isEnd": isEnd,
            "chiefUser": chiefUser,
            "category": category,
            "fine": fine
        ]
        
        AF.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                if let value = response.value {
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do{
                                let decoder = JSONDecoder()
                                let result = try
                                    decoder.decode(Response.self, from: value)
                                
                                completion(.success(result))
                            } catch {
                                completion(.pathErr)
                            }
                        case 409:
                            completion(.pathErr)
                        case 500:
                            completion(.serverErr)
                        default:
                            break
                        }
                    }
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
}
