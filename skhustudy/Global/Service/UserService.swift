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
    
    func sendEmail(_ email: String, _ text: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.SendEmail
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
            "email" : email,
            "myName" : "StudyTogether",
            "subject" : "이메일 인증",
            "text" : text
        ]
        
        AF.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.value {
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            completion(.success("이메일 전송 성공"))
                        case 409:
                            completion(.pathErr)
                        case 500:
                            completion(.serverErr)
                        default: break
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
    
    // MARK: - register(sign up)
    
    func regitser(email: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.Register
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
            "email" : email,
            "password" : password
        ]
<<<<<<< HEAD
        
        AF.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
=======

        AF.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData {
            response in
            
            print(response)
            
>>>>>>> 19a90bbfb86ff2d8a0f1f12e02449087929b81ea
            switch response.result {
                
            case .success:
<<<<<<< HEAD
                if let status = response.response?.statusCode {
                    switch status {
                    case 200:
                        completion(.success("회원가입 성공"))
                    case 409:
                        completion(.pathErr)
                    case 500:
                        completion(.serverErr)
                    default:
                        break
                        
                    }
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    // MARK: - Get Category
    func getCategory(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.GetCategory
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
=======
>>>>>>> 19a90bbfb86ff2d8a0f1f12e02449087929b81ea
                if let value = response.value {
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
<<<<<<< HEAD
                            if let rawJSON = try? JSONSerialization.jsonObject(with: value),
                                let json = rawJSON as? [String: Any],
                                let resultsArray = json["data"] as? [[String: Any]]{
                                let categories = resultsArray.compactMap {Category(dictionary: $0)}
                                completion(.success(categories))
=======
                            do{
                                let decoder = JSONDecoder()
                                let result = try
                                    decoder.decode(Response.self, from: value)
                                
                                completion(.success(result))
                            } catch {
                                completion(.pathErr)
>>>>>>> 19a90bbfb86ff2d8a0f1f12e02449087929b81ea
                            }
                        case 409:
                            completion(.pathErr)
                        case 500:
                            completion(.serverErr)
                        default:
                            break
<<<<<<< HEAD
                            
=======
>>>>>>> 19a90bbfb86ff2d8a0f1f12e02449087929b81ea
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
    
    
    // MARK: -
    
}
