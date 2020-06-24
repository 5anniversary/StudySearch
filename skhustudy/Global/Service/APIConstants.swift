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
    static let GetUserInfo = BaseURL + "/users/userinfo"                    // POST
    static let ModifyUserInfo = BaseURL + "/users/updateInfo"               // POST
    static let GetUserStudyInfo = BaseURL + "/study/mystudy"                // GET
    
    // 카테고리
    static let GetCategory = BaseURL + "/getCategory"                       // GET
    
    // 스터디
    static let CreateStudy = BaseURL + "/study/create"                      // POST
    static let GetStudyList = BaseURL + "/study/getinfo"                    // GET
    static let GetStudyDetailInfo = BaseURL + "/study/getstudyinfo"         // POST
    static let GetStudySearch = BaseURL + "/study/search"                   // GET
    static let AddStudyUser = BaseURL + "/study/addstudyuser"               // POST
    static let GetStudyPenaltyInfo = BaseURL + "/study/fine"                // GET
    
    // 챕터 별 정보
    static let GetStudyChapterList = BaseURL + "/chapter/chapterlist"       // POST
    static let CreateStudyChapter = BaseURL + "/chapter/create"             // POST
    static let GetChapterPenalty = BaseURL + "/chapter/check"               // GET
}
