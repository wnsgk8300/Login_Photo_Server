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

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        KakaoSDKCommon.initSDK(appKey: "36f8f2bc86cec81d0b898b31e6dd41fd")
        
        
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

