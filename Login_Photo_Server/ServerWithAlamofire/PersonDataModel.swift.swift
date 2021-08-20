//
//  PersonDataModel.swift.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/20.
//

import Foundation

//JSON형식의 데이터를 Decode를 통해 Swift의 데이터 모델로 변환해주어야함

//그러기 위해서 데이터 모델 구조체 파일을 하나 만들고 Codable 프로토콜을 채택해줍니다.
//Codable은 Decodable과 Encodable 프로토콜이 합쳐진 프로토콜입니다.

struct PersonDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Person
}

struct Person: Codable {
    let name, profileMessage: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileMessage = "profile_message"
    }
}
