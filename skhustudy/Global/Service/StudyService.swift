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
    
    // MARK: - Study Create
    
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
    
    // MARK: - Study List
    
    func getStudyList(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.GetStudyList
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData {
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
                                    decoder.decode(StudyList.self, from: value)
                                
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
    
    // MARK: - Study Detail Information
    
    func getStudyDetailInfo(token: String, id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.GetStudyDetailInfo
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
                "token": token,
                "id": id
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
                                    decoder.decode(StudyInfo.self, from: value)
                                
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
    
    // MARK: - Study Chapter List
    
    func getStudyChapterList(token: String, id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.GetStudyChapterList
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
                "token": token,
                "id": id
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
                                    decoder.decode(StudyChapterList.self, from: value)
                                
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
    
    // MARK: - Create Study Chapter
    
    func createStudyChapter(token: String, id: Int,content: String, date: String, place: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.CreateStudyChapter
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
                "token": token,
                "id": id,
                "content": content,
                "date": date,
                "place": place
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
