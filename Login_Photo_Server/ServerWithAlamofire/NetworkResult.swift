//
//  NetworkResult.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/20.
//

import Foundation



//서버 통신 결과 처리

//T: 타입 파라미터로,당장은 타입을 정해두지 않겠다.
enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}



