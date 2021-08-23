//
//  MyAlamofireManager.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/23.
//

import Foundation
import Alamofire


final class MyAlamofireManager {

    // 싱글턴 적용
    static let shared = MyAlamofireManager()
    
    // 인터셉터 - API호출할 때 가로채서 공통 파라미터를 넣는다든지 토큰인증을 하는 등
    let interceptors = Interceptor(interceptors: [BaseInterceptor()])
    
    // 로거 설정
    let monitors = [MyLogger()]
    
    // 세션 설정
    var session: Session
    
    private init() {
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}
