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

import SwiftKeychainWrapper
import SnapKit
import Then

class LoginVC: UIViewController {
    
    // MARK: - UI components
    
    // 로그인 화면
    let titleLogoImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "study_together_logo")
        $0.contentMode = .scaleAspectFit
    }
    
    let idLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = .systemFont(ofSize: 13)
        $0.sizeToFit()
        $0.textColor = .black
    }
    
    let loginIDTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 50)).then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.placeholder = "email@study.com"
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        $0.text = "3@3.com" // 개발 편리성을 위한 임시 삽입 코드
        $0.keyboardType = .emailAddress
    }
    
    let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .systemFont(ofSize: 13)
        $0.sizeToFit()
        $0.textColor = .black    }
    
    let loginPWTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.isSecureTextEntry = true
        $0.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        $0.text = "111111" // 개발 편리성을 위한 임시 삽입 코드
    }
    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.makeRounded(cornerRadius: 20)
        $0.backgroundColor = .signatureColor
        $0.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    // 회원가입 화면
    let signUpLabel = UILabel().then {
        $0.text = "처음이시라면"
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .gray
    }
    let leftLineView = UIView().then {
        $0.backgroundColor = .gray
    }
    let rightLineView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let normalSignUpButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapNormalSignUpButton), for: .touchUpInside)
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.signatureColor, for: .normal)
        $0.makeRounded(cornerRadius: 5)
    }
    
    // MARK: - Variables and Properties
    
    var userInfo: User?
    var userID = KeychainWrapper.standard.string(forKey: "userID")
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Helper
   
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
                let navigationController = UINavigationController()
                navigationController.modalPresentationStyle = .fullScreen
                navigationController.pushViewController(vc, animated: true)
                self.present(navigationController, animated: true)
                
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
        if email != "" && loginPWTextField.text?.count ?? 0 >= 1 {
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
                        self.userID = responseData.data.userID
                        KeychainWrapper.standard.set(self.userID ?? "", forKey: "userID")
                        
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
        UserService.shared.getUserInfo(userID ?? "") { result in
        
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
