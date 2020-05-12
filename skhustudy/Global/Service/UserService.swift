//
//  UserService.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/12.
//  Copyright © 2020 anniversary. All rights reserved.
//

import Foundation
import Alamofire

struct UserService {
    
    private init() {}
    
    static let shared = UserService()
    
    // MARK: - 회원가입
    
//    func sendEmail(_ email: String, _ myName: String, _ subject: String, _ text: String, completion: @escaping (NetworkResult<Any>) -> Void) {
//
//        let URL = APIConstants.SendEmail
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json"
//        ]
//
//        let body : Parameters = [
//            "email" : email,
//            "myName" : myName,
//            "subject" : subject,
//            "text" : text
//        ]
//
//        AF.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
//            response in
//
//            switch response.result {
//
//            case .success:
//                // parameter 위치
//                if let value = response.value {
//                    if let status = response.response?.statusCode {
//                        switch status {
//                        case 200:
//                            do{
//                                let decoder = JSONDecoder()
//                                let result = try decoder.decode(sendEmail.self, from: value)
//                                completion(.success(result))
//                            } catch {
//                                completion(.pathErr)
//                            }
//                        case 409:
//                            completion(.pathErr)
//                        case 500:
//                            completion(.serverErr)
//                        default:
//                            break
//                        }
//                    }
//                }
//                break
//            case .failure(let err):
//                print(err.localizedDescription)
//                completion(.networkFail)
//            }
//        }
//    }
    
    
    // MARK: - sign in
    
    // MARK: -
    
//    func getCategory(completion: @escaping (NetworkResult<Any>) -> Void) {
//
//        let URL = APIConstants.Logout
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
//        ]
//
//        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
//            response in
//
//            switch response.result {
//
//            case .success:
//                if let status = response.response?.statusCode {
//                    switch status {
//                    case 200:
//                        completion(.success("로그아웃 성공"))
//                    case 409:
//                        completion(.pathErr)
//                    case 500:
//                        completion(.serverErr)
//                    default:
//                        break
//
//                    }
//                }
//                break
//            case .failure(let err):
//                print(err.localizedDescription)
//                completion(.networkFail)
//            }
//        }
//    }
    
    // MARK: -
    
    // MARK: -
    
}
