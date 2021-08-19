//
//  ViewController.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/18.
//

import UIKit
import SnapKit
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import SnapKit

class ViewController: UIViewController {
    let kb = UIButton()
    let kb2 = UIButton()
    let infoLabel = UILabel()
    let profileImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        view.backgroundColor = .brown
    }
    
    //앱으로 로그인
    @objc
    func onKakaoLoginByAppTouched(_ sender: Any) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    // 예외 처리 (로그인 취소 등)
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    // do something
                    _ = oauthToken
                    // 어세스토큰
                    let accessToken = oauthToken?.accessToken
                    
                    //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                    self.setUserInfo()
                }
            }
        }
        
    }
    
    
    //폰(시뮬레이터)에 앱이 안깔려 있을때 웹 브라우저를 통해 로그인
    @objc
    func onKakaoLoginByWebTouched(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                // 어세스토큰
                let accessToken = oauthToken?.accessToken
                
                //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                self.setUserInfo()
                print(accessToken ?? "엄서용")
            }
        }
    }
    
    func setUserInfo() {
        
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                self.infoLabel.text = user?.kakaoAccount?.profile?.nickname
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                    let data = try? Data(contentsOf: url) {
                    self.profileImageView.image = UIImage(data: data)
                }
            }
        }
    }

    func setUI() {
        [kb, kb2, profileImageView, infoLabel].forEach {
            view.addSubview($0)
        }
        
        kb.backgroundColor = .yellow
        kb2.backgroundColor = .red
        kb.addTarget(self, action: #selector(onKakaoLoginByAppTouched(_:)), for: .touchUpInside)
        kb2.addTarget(self, action: #selector(onKakaoLoginByWebTouched(_:)), for: .touchUpInside)
        
        kb.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(40)
        }
        kb2.snp.makeConstraints {
            $0.centerX.height.width.equalTo(kb)
            $0.top.equalTo(kb.snp.bottom).inset(10)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(kb2.snp.bottom).inset(10)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(50)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).inset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        
        
        
        
    }
}


