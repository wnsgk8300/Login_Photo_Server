//
//  AlamoVC.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/27.
//

import Foundation
import UIKit
import Alamofire

class AlamoVC: UIViewController {
//    let url = "https://ptsv2.com/t/nppsl-1630637392/post"
//    let url = "https://httpbin.org/post"
    let url = "http://127.0.0.1:8000/auth/signup"
    let image1 = UIImage(named: "NaverLogo")
    let image2 = UIImage(named: "ip")
    
//    let headers: HTTPHeaders = ["Content-type": "multipart/form-data", "Content-Disposition" : "form-data"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
//                getTest()
        postTest()
//        uploadPhoto(media: image2!, params: ["1": "2"], fileName: "df")
//        upload1()
    }
    
    /*method 에 어떤 통신방식 사용할건지 넣고
     parameters 는 밑에서 post 통신할 때 보내볼거고요
     encoding 은 URL 이니까 URLEncoding 적어주시고요
     headers 는 json 형식으로 받게끔 써줍니다.
     validate 는 확인 코드입니다.
     responseJSON 이 정보를 받는 부분입니다.*/
    func getTest() {
        AF.request(url,
                   //어떤 방식으로 통신을 하나
                   method: .get,
                   parameters: nil,
                   //url이니까 urlencoging
                   encoding: URLEncoding.default,
                   //json형식으로 받게끔
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            //확인 코드                        정보 받는 부분
            .validate(statusCode: 200..<300).responseJSON { (json) in
                //가져온 데이터 활용
                print("AlamoVC")
                print(json)
                print("AlamoVC")
            }
    }
    
    func postTest() {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        //POST로 보낼 정보
        let params = ["id": "아이디", "pw": "패스워드"] as Dictionary
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("성공")
            case .failure:
                print("error")
            }
        }
    }
    func uploadPhoto(media: UIImage,params: [String:String],fileName: String){
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(media.jpegData(
                    compressionQuality: 1)!,
                    withName: "1",
                    fileName: "\(fileName).jpeg", mimeType: "image/jpeg"
                )
                for param in params {
                    let value = param.value.data(using: String.Encoding.utf8)!
                    multipartFormData.append(value, withName: param.key)
                }
            },
            to: url,
            method: .post ,
            headers: headers
        )
        .response { response in
            print(response)
        }
    }
//    func upload1() {
//        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(Data("photo".utf8), withName: "iphonePhoto")
//            multipartFormData.append(self.image2!.jpegData(compressionQuality: 1)!, withName: "iphone", fileName: "ip", mimeType: "image/jpeg")
//        }, to: url,
//        headers: headers)
//    }
}
