//
//  LoginVC.swift
//  skhustudy
//
//  Created by Junhyeon on 2020/04/09.
//  Copyright © 2020 skhuStudy. All rights reserved.
//

import UIKit

import AuthenticationServices
import CryptoKit
import FirebaseAuth
import KakaoOpenSDK
import SnapKit
import Then
import FBSDKLoginKit

class LoginVC: UIViewController {
    
    // MARK: - UI components
    
    let appleLoginButton = ASAuthorizationAppleIDButton().then{ _ in 
        //        $0.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
    }
    
    let kakaoLoginButton = KOLoginButton().then {
        $0.addTarget(self, action: #selector(didTapKakaoLoginButton), for: .touchUpInside)
    }
    
    //
    //    let facebookLoginButton = ASAuthorizationAppleIDButton().then{
    //        $0.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
    //    }
    
    let facebookLoginButton = FBLoginButton().then {
        $0.makeRounded(cornerRadius: 5)
    }
    
    // MARK: - Variables and Properties
    
    fileprivate var currentNonce: String?
    let session = KOSession.shared()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        
        checkFBSignSuccessful()
    }
    
    
    // MARK: - Helper
    
    func addSubView(){

        self.view.addSubview(appleLoginButton)
        self.view.addSubview(kakaoLoginButton)
        self.view.addSubview(facebookLoginButton)
        
        appleLoginButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview().offset(100)
            make.height.equalTo(40)
        }
        
        kakaoLoginButton.snp.makeConstraints { (make) in
            make.top.equalTo(appleLoginButton).offset(60)
            make.left.equalTo(appleLoginButton)
            make.right.equalTo(appleLoginButton)
            make.height.equalTo(40)
        }
        
        facebookLoginButton.snp.makeConstraints { (make) in
            make.top.equalTo(kakaoLoginButton).offset(60)
            make.left.equalTo(appleLoginButton)
            make.right.equalTo(appleLoginButton)
            make.height.equalTo(40)
        }
        // make.height.equalTo() 작동 오류를 대신할 코드
        facebookLoginButton.constraints.first(where: { (constraint) -> Bool in
            return constraint.firstAttribute == .height
        })?.constant = 40.0
        
    }
    
    func checkFBSignSuccessful() {
        // Observe access token changes
        // This will trigger after successfully login / logout
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
    }
    
    //    @objc func didTapAppleLoginButton() {
    //        let nonce = randomNonceString()
    //        currentNonce = nonce
    //        let appleIDProvider = ASAuthorizationAppleIDProvider()
    //        let request = appleIDProvider.createRequest()
    //        request.requestedScopes = [.fullName, .email]
    //        request.nonce = sha256(nonce)
    //
    //        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    //        authorizationController.delegate = self
    //        authorizationController.presentationContextProvider = self
    //        authorizationController.performRequests()
    //    }
    
    @objc func didTapKakaoLoginButton() {
        guard let session = KOSession.shared() else {
            return
        }
        
        if session.isOpen() {
            session.close()
        }
        
        session.open { (error) in
            if error != nil || !session.isOpen() { return }
            KOSessionTask.userMeTask(completion: { (error, user) in
                guard let user = user,
                    let email = user.account?.email,
                    let gender = user.account?.gender,
                    let nickname = user.account?.profile?.nickname,
                    let profileImageURL = user.account?.profile?.profileImageURL else { return }
    
                let genderString = gender.rawValue > 0 ? "남" : "여"
                
//                print("email = \(email), gender = \(genderString), nickname = \(nickname)")
            })
        }
        
    }
    
    //    private func sha256(_ input: String) -> String {
    //        let inputData = Data(input.utf8)
    //        let hashedData = SHA256.hash(data: inputData)
    //        let hashString = hashedData.compactMap {
    //            return String(format: "%02x", $0)
    //        }.joined()
    //
    //        return hashString
    //    }
    //
    //    private func randomNonceString(length: Int = 32) -> String {
    //        precondition(length > 0)
    //        let charset: Array<Character> =
    //            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    //        var result = ""
    //        var remainingLength = length
    //
    //        while remainingLength > 0 {
    //            let randoms: [UInt8] = (0 ..< 16).map { _ in
    //                var random: UInt8 = 0
    //                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
    //                if errorCode != errSecSuccess {
    //                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
    //                }
    //                return random
    //            }
    //
    //            randoms.forEach { random in
    //                if length == 0 {
    //                    return
    //                }
    //
    //                if random < charset.count {
    //                    result.append(charset[Int(random)])
    //                    remainingLength -= 1
    //                }
    //            }
    //        }
    //
    //        return result
    //    }
}



// MARK: - AppleLogin Extension

//extension LoginVC : ASAuthorizationControllerDelegate{
//    func authorizationController(controller: ASAuthorizationController,
//                                 didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            // Create an account in your system.
//            guard let nonce = currentNonce else {
//                fatalError()
//            }
//            guard let appleIDToken = appleIDCredential.identityToken else {
//                print("Unable to fetch identity token")
//                return
//            }
//            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//                return
//            }
//
//            let credential = OAuthProvider.credential(withProviderID: "apple.com",
//                                                      idToken: idTokenString,
//                                                      rawNonce: nonce)
//
//            print("Credential : ",credential)
//            Auth.auth().signIn(with: credential) { (authResult, error) in
//                if (error != nil) {
//                    print(error?.localizedDescription ?? "")
//                    return
//                }
//            }
//        }
//
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        // handle Error.
//    }
//
//
//
//}
//
//extension LoginVC : ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//
//
//}
