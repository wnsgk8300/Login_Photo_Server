//
//  AppleLoginViewContrller.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/24.
//

import Foundation
import AuthenticationServices

class AppleLoginViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    //버튼을 눌렀을 때 Apple 로그인을 모달 시트로 표시함
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUI()
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
            
            print("User ID: \(userIdentifier)")
            print("User name: \(String(describing: fullName))")
            print("User emsil: \(String(describing: email))")
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
