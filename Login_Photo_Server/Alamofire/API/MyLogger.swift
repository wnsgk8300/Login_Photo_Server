//
//  MyLogger.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/23.
//

import Foundation
import Alamofire

final class MyLogger: EventMonitor {
    let queue = DispatchQueue(label: "ApiLog")
    
    func requestDidResume(_ request: Request) {
        print("MyLogger - requestDidResume")
        debugPrint(request)
        
    }
//    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
//
//    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("MyLogger - request.didParseResponse()")
        debugPrint(response)
    }
}
