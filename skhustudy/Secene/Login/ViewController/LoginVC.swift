//
//  LoginVC.swift
//  skhustudy
//
//  Created by Junhyeon on 2020/04/14.
//  Copyright © 2020 skhuStudy. All rights reserved.
//
import UIKit
import SnapKit
import Then
import FBSDKLoginKit

class LoginVC: UIViewController {
    
    // MARK: - UI components
    
    let appleLoginButton = UIButton().then {
        $0.setTitle("🍎APPLE LOGIN", for: .normal)
        $0.backgroundColor = .lightGray
        $0.makeRounded(cornerRadius: 5)
    }
    
    let facebookLoginButton = FBLoginButton().then {
        $0.makeRounded(cornerRadius: 5)
    }
    
    let normalLoginButton = UIButton().then {
        $0.setTitle("SKHU STUDY로 회원가입하기", for: .normal)
        $0.backgroundColor = .greenLight
        $0.makeRounded(cornerRadius: 5)
    }
    
    // MARK: - Variables and Properties
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        
        checkFBSignSuccessful()
    }
    
    
    // MARK: - Helper
    
    func addSubView(){

        self.view.addSubview(appleLoginButton)
        self.view.addSubview(facebookLoginButton)
        self.view.addSubview(normalLoginButton)
        
        appleLoginButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview().offset(100)
            make.height.equalTo(40)
        }
        
        facebookLoginButton.snp.makeConstraints { (make) in
            make.top.equalTo(appleLoginButton).offset(60)
            make.left.equalTo(appleLoginButton)
            make.right.equalTo(appleLoginButton)
            make.height.equalTo(40)
        }
        // make.height.equalTo() 작동 오류를 대신할 코드
        facebookLoginButton.constraints.first(where: { (constraint) -> Bool in
            return constraint.firstAttribute == .height
        })?.constant = 40.0
        
        normalLoginButton.snp.makeConstraints{ (make) in
            make.top.equalTo(facebookLoginButton).offset(60)
            make.left.equalTo(facebookLoginButton)
            make.right.equalTo(facebookLoginButton)
            make.height.equalTo(40)
        }
    }
    
    func checkFBSignSuccessful() {
        // Observe access token changes
        // This will trigger after successfully login / logout
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
    }

}
