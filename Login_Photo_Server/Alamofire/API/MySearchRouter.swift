//
//  MySearchRouter.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/23.
//

import Foundation
import Alamofire

//https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#adding-a-requestinterceptor

//검색 관련 api호출
enum MySearchRouter: URLRequestConvertible {
    case searchPhotos(term: String)
    case searchUsers(term: String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "search/")!
    }
    
    //http 연결방식
    var method: HTTPMethod {
        switch self {
        case .searchPhotos, .searchUsers:
            return .get
        }
//        switch self {
//        case .searchPhotos:
//            return .get
//        case .searchUsers:
//            return .post
//        }
    }
    
    var endPoint: String {
        switch self {
        case .searchPhotos:
            return "photos/"
        case .searchUsers:
            return "users/"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case let .searchPhotos(term), let .searchUsers(term):
            return ["query" : term]
        }
    }
    
    //throw이기때문에 바깥으로 에러가 나가게됨
    func asURLRequest() throws -> URLRequest {
        //baseURL에 string 추가
        let url = baseURL.appendingPathComponent(endPoint)
        
        print("MySearchRouter - asURLRequest() url: \(url)")

        var request = URLRequest(url: url)
        
        request.method = method
        
        //위의 throws로 에러가 밖으로 나가기 때문에 여기선 tyr만 해주면 됨
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        
//        switch self {
//        case let .get(parameters):
//            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//        case let .post(parameters):
//            request = try JSONParameterEncoder().encode(parameters, into: request)
//        }
        
        return request
    }
}
