//
//  Constant.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/23.
//

import Foundation

enum API {
    static let BASE_URL : String = "https://api.unsplash.com/"
    
    //unplash에서 발급받은 id
    static let CLIENT_ID : String = "_LQuhTiLv0aWgoMv30d9opis3JR9WeT7_8-ZXzJE2oY"
    
}

enum NOTIFICATION {
    enum API {
        static let AUTH_FAIL = "authentication_fail"
    }
}
