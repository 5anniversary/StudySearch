//
//  APIConstants.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/12.
//  Copyright © 2020 anniversary. All rights reserved.
//

// Reference from https://github.com/SKHU-STUDY/Server/wiki

struct APIConstants {

    static let BaseURL = "https://skhuserver.herokuapp.com"
    
    // 회원가입
    static let Register = BaseURL + "/users/register"                       // POST
    static let SendEmail = BaseURL + "/sendEmail"                           // POST
    
    // 개인 정보
    static let Login = BaseURL + "/users/login"                             // POST
    static let Logout = BaseURL + "/users/exit"                             // POST
    static let ChagePassword = BaseURL + "/users/changePassword"            // POST
    
    // 사용자 정보
    static let GetUserInfo = BaseURL + "/users/getUserInfo"                 // POST
    static let ModifyUserInfo = BaseURL + "/users/updateInfo"               // POST
    static let GetCategory = BaseURL + "/getCategory"                       // GET
    
    // 스터디
    static let CreateStudy = BaseURL + "/study/create"                      // POST
}
