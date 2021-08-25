//
//  AppleLoginViewContrller.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/24.
//

import Foundation
import AuthenticationServices

class AppleLoginViewController: UIViewController {
   
    // Apple ID 로그인 버튼 생성
    let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUI()
    }
}

extension AppleLoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    //버튼을 눌렀을 때 Apple 로그인을 모달 시트로 표시함
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Login Error")
    }
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        //Applt ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            //계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if let authorizationCode = appleIDCredential.authorizationCode,
               let identityToken = appleIDCredential.identityToken,
               let authString = String(data: authorizationCode, encoding: .utf8),
               let tokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
                
            }
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            
        case let passwordCredential as ASPasswordCredential:
        // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
}

extension AppleLoginViewController {
    @objc
    func appleSignInButtonPress(_ sender: ASAuthorizationAppleIDButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension AppleLoginViewController {
    func setUI() {
        setDetails()
        setLayout()
    }
    func setDetails() {
        authorizationButton.addTarget(self, action: #selector(appleSignInButtonPress(_:)), for: .touchUpInside)
        
        
    }
    func setLayout() {
        [authorizationButton].forEach {
            view.addSubview($0)
        }
        authorizationButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(60)
        }
    }
}
