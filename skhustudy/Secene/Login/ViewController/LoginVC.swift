//
//  LoginVC.swift
//  skhustudy
//
//  Created by Junhyeon on 2020/04/14.
//  Copyright © 2020 skhuStudy. All rights reserved.
//
import UIKit
import AuthenticationServices

import Firebase
import FirebaseAuth
import FBSDKLoginKit

import SwiftKeychainWrapper
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
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.placeholder = "email@study.com"
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        $0.text = "2@2.com" // 개발 편리성을 위한 임시 삽입 코드
    }
    let loginPWTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        $0.text = "111111" // 개발 편리성을 위한 임시 삽입 코드
    }
    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.makeRounded(cornerRadius: 10)
        $0.backgroundColor = .signatureColor
//        $0.isEnabled = false
//        $0.alpha = 0.5
        $0.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    // 회원가입 화면
    let signUpLabel = UILabel().then {
        $0.text = "다음으로 회원가입"
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .gray
    }
    let leftLineView = UIView().then {
        $0.backgroundColor = .gray
    }
    let rightLineView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let appleLoginButton = ASAuthorizationAppleIDButton()
    
    let facebookLoginButton = FBLoginButton().then {
        $0.makeRounded(cornerRadius: 5)
    }
    let normalSignUpButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapNormalSignUpButton), for: .touchUpInside)
        $0.setTitle("SKHU STUDY로 회원가입하기", for: .normal)
        $0.backgroundColor = .signatureColor
        $0.makeRounded(cornerRadius: 5)
    }
    
    // MARK: - Variables and Properties
    
    var userInfo: User?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        
        checkFBSignSuccessful()
        
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Helper

    func checkFBSignSuccessful() {
        // Observe access token changes
        // This will trigger after successfully login / logout
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
    }
   
    func login() {
        getUserInfoService(completionHandler: {(returnedData) -> Void in
            
            switch self.userInfo?.status {
            case 200:
                // 일반 로그인 성공 시 메인 화면으로 전환
                let sb = UIStoryboard(name: "TabBar", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                vc.modalPresentationStyle = .fullScreen

                self.present(vc, animated: true)
                
            case 400:
                // 최초 로그인 시 기본 사용자 정보입력 창으로 전환
                let sb = UIStoryboard(name: "AddMoreUserInformation", bundle: nil)
                let vc = sb.instantiateViewController(identifier: "AddUserInfoVC") as! AddUserInfoVC
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 406, 411, 500, 420, 421, 422, 423:
                // 실패 시 알림 창 띄우기
                self.simpleAlert(title: self.userInfo?.message ?? "서버 통신오류", message: "")

            default:
                self.simpleAlert(title: "오류가 발생하였습니다", message: "")
            }
        })
        
    }
    
    @objc func didTapLoginButton() {
        loginService(email: loginIDTextField.text!, password: loginPWTextField.text!) // 입력 값 조건은 textFieldDidChange에서 확인(! 사용 ok)
    }
    
    @objc func didTapNormalSignUpButton() {
        let sb = UIStoryboard(name: "EmailVerification", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EmailVerificationVC") as! EmailVerificationVC
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(vc, animated: true)
        self.present(navigationController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

// MARK: - TextField Delegate

extension LoginVC: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        // 로그인 입력 조건 확인
        let email = loginIDTextField.text
        if email?.validateEmail() ?? false && loginPWTextField.text?.count ?? 0 >= 6 {
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
        } else {
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
        }
    }
    
}

// MARK: - User Service

extension LoginVC {
    
    func loginService(email: String, password: String) {
        UserService.shared.login(email: email, password: password) { result in
        
            switch result {
                case .success(let res):
                    let responseData = res as! Response
                    
                    switch responseData.status {
                    case 200:
                        let token = responseData.data.accessToken
                        KeychainWrapper.standard.set(token, forKey: "token")
                        let userID = responseData.data.userID
                        KeychainWrapper.standard.set(userID, forKey: "userID")
                        
                        self.login()
                        
                    case 400, 406, 411, 500, 420, 421, 422, 423:
                        self.simpleAlert(title: responseData.message, message: "")
                        
                    default:
                        self.simpleAlert(title: "오류가 발생하였습니다", message: "")
                    }
                case .requestErr(_):
                    print(".requestErr")
                case .pathErr:
                    print(".pathErr")
                case .serverErr:
                    print(".serverErr")
                case .networkFail:
                    print(".networkFail")
            }
            
        }
    }
    
    func getUserInfoService(completionHandler: @escaping (_ returnedData: User) -> Void ) {
        UserService.shared.getUserInfo() { result in
        
            switch result {
                case .success(let res):
                    self.userInfo = res as? User
                    let id = self.userInfo?.data.id
                    KeychainWrapper.standard.set(id ?? 0, forKey: "id")
                    let nickname = self.userInfo?.data.nickName
                    KeychainWrapper.standard.set(nickname ?? "", forKey: "nickname")
                    let image = self.userInfo?.data.image
                    KeychainWrapper.standard.set(image ?? "", forKey: "image")
                    completionHandler(self.userInfo!)
                
                case .requestErr(_):
                    print(".requestErr")
                case .pathErr:
                    print(".pathErr")
                case .serverErr:
                    print(".serverErr")
                case .networkFail:
                    print(".networkFail")
            }
            
        }
    }
    
}
