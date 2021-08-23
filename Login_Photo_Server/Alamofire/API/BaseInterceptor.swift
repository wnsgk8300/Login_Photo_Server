//
//  BaseInterceptor.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/23.
//

import Foundation
import Alamofire

class BaseInterceptor:Interceptor {
    // vc4의 AF.request가 호출될 때 같이 호출되는 것
    override func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("BaseInterceptor - adapt() called")
    
        var request = urlRequest
        
        //application/json: error같은게 발생햇을 때 json형태로 받는것
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        //공통 파라미터 추가
//        var dictionary = [String:String]()
//        dictionary.updateValue(API.CLIENT_ID, forKey: "client_id")
//        
//        do {
//            request = try URLEncodedFormParameterEncoder().encode(dictionary, into: request)
//        } catch {
//            print(error)
//        }

        completion(.success(request))
    }
    //API호출을 햇는데 정상적으로 작동이 안되면 여기서 핸들링한다
    override func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("BaseInterceptor - retry() called")
        //statusCode가 안들어왔을 때 이 로직을 탐
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        //statusCode가 있을 때
        let data = ["statusCode": statusCode]
        
        //NotificationCenter로 데이터 날림
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil, userInfo: data)
        
        completion(.doNotRetry)
    }
}
