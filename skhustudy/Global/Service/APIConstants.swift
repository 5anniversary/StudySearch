//
//  APIConstants.swift
//  SKHUStudy
//
//  Created by Hee Jae Kim on 2020/05/12.
//  Copyright © 2020 anniversary. All rights reserved.
//

// Reference from https://github.com/SKHU-STUDY/Server/wiki

struct APIConstants {

    static let BaseURL = "http://skhuserver.herokuapp.com"
        
    static let Register = BaseURL + "/users/register"                       // POST
    static let SendEmail = BaseURL + "/sendEmail"                           // POST
    
    static let Login = BaseURL + "/users/login"                             // POST
    static let Logout = BaseURL + "/users/exit"                             // POST
    static let ChagePassword = BaseURL + "/users/changePassword"            // POST
    
    static let GetUserInfo = BaseURL + "/users/getUserInfo"                 // POST
    static let ModifyUserInfo = BaseURL + "/users/updateInfo"               // POST
    static let GetCategory = BaseURL + "/getCategory"                       // GET
}
