//
//  AppDelegate.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/18.
//

import UIKit
import Firebase
import GoogleSignIn
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        FirebaseApp.configure()
        //        KakaoSDKCommon.initSDK(appKey: "36f8f2bc86cec81d0b898b31e6dd41fd")
        
//     앱 실행 시 로그인 상태 확인
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "001976.6e8d35032d074d48a5816623627dec2e.0254"/* 로그인에 사용한 User Identifier */) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid.
                print("해당 ID는 연동되어있습니다.")
            case .revoked:
            // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
            print("해당 ID는 연동되어있지않습니다.")
            case .notFound:
                // The Apple ID credential is either was not found, so show the sign-in UI.
                print("해당 ID를 찾을 수 없습니다.")
            default:
                break
            }
    }
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = AppleLoginViewController()
            window?.backgroundColor = .systemBackground
            window?.makeKeyAndVisible()
            return true
        }
    

func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if (AuthApi.isKakaoTalkLoginUrl(url)) {
        return AuthController.handleOpenUrl(url: url)
    }
    return false
}
func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
    if let error = error {
        print(error)
        return
    }
}

}
