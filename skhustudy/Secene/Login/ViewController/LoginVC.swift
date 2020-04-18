//
//  LoginVC.swift
//  skhustudy
//
//  Created by Junhyeon on 2020/04/14.
//  Copyright © 2020 skhuStudy. All rights reserved.
//
import UIKit
import AuthenticationServices

import FBSDKLoginKit
import SnapKit
import Then

class LoginVC: UIViewController {
    
    // MARK: - UI components
    
    // 로그인 화면
    let titleLabel = UILabel().then {
        $0.text = "SKHU STUDY"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 40.0)
    }
    let loginIDTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 50)).then {
        $0.placeholder = "아이디 입력"
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
    }
    let loginPWTextField = UITextField().then {
        $0.placeholder = "비밀번호 입력"
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
    }
    let loginButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.makeRounded(cornerRadius: 10)
        $0.backgroundColor = .systemOrange
    }
    
    // 회원가입 화면
    let signUpLabel = UILabel().then {
        $0.text = "다음으로 회원가입"
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
    }
    let appleLoginButton = ASAuthorizationAppleIDButton()
    
    let facebookLoginButton = FBLoginButton().then {
        $0.makeRounded(cornerRadius: 5)
    }
    let normalLoginButton = UIButton().then {
        $0.setTitle("SKHU STUDY로 회원가입하기", for: .normal)
//        $0.backgroundColor = .greenLight
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

        self.view.addSubview(titleLabel)

        self.view.addSubview(loginIDTextField)
        self.view.addSubview(loginPWTextField)

        self.view.addSubview(loginButton)

        self.view.addSubview(signUpLabel)
        self.view.addSubview(appleLoginButton)
        self.view.addSubview(facebookLoginButton)
        self.view.addSubview(normalLoginButton)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }

        loginIDTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(titleLabel).offset(100)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(50)
        }

        loginPWTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(loginIDTextField.snp.bottom).offset(10)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(50)
        }

        loginButton.snp.makeConstraints{ (make) in
            make.top.equalTo(loginPWTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }

        
        signUpLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }

        appleLoginButton.snp.makeConstraints { (make) in
            make.top.equalTo(signUpLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        
        facebookLoginButton.snp.makeConstraints { (make) in
            make.top.equalTo(appleLoginButton).offset(50)
            make.left.equalTo(appleLoginButton)
            make.right.equalTo(appleLoginButton)
            make.height.equalTo(40)
        }
        // make.height.equalTo() 작동 오류를 대신할 코드
        facebookLoginButton.constraints.first(where: { (constraint) -> Bool in
            return constraint.firstAttribute == .height
        })?.constant = 40.0
        
        normalLoginButton.snp.makeConstraints{ (make) in
            make.top.equalTo(facebookLoginButton).offset(50)
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
    
    @objc func didTapLoginButton() {
        let sb = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        vc.modalPresentationStyle = .fullScreen

        self.present(vc, animated: true)
    }

}
