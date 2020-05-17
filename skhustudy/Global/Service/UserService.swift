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
        
        AF.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData {
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
                                print("decode 과정 실패")
                                completion(.pathErr)
                            }
                        case 409:
                            print("걍 실패")
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
    
    // MARK: - Login
    
    func login(email: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void) {

        let URL = APIConstants.Login
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
            "email" : email,
            "password" : password
        ]

        AF.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData {
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
                                print("decode 과정 실패")
                                completion(.pathErr)
                            }
                        case 409:
                            print("걍 실패")
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
                if let value = response.value {
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            if let rawJSON = try? JSONSerialization.jsonObject(with: value),
                                let json = rawJSON as? [String: Any],
                                let resultsArray = json["data"] as? [[String: Any]]{
                                let categories = resultsArray.compactMap {Category(dictionary: $0)}
                                completion(.success(categories))
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
