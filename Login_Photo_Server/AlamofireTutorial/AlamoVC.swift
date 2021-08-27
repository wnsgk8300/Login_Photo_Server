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
    override func viewDidLoad() {
        super.viewDidLoad()
//        getTest()
        postTest()
        
    }
    /*method 에 어떤 통신방식 사용할건지 넣고
     parameters 는 밑에서 post 통신할 때 보내볼거고요
     encoding 은 URL 이니까 URLEncoding 적어주시고요
     headers 는 json 형식으로 받게끔 써줍니다.
     validate 는 확인 코드입니다.
     responseJSON 이 정보를 받는 부분입니다.*/
    func getTest() {
        let url = "https://jsonplaceholder.typicode.com/todos/1"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300).responseJSON { (json) in
                //가져온 데이터 활용
                print("AlamoVC")
                print(json)
                print("AlamoVC")
            }
    }
    
    func postTest() {
        let url = "https://ptsv2.com/t/xwc5t-1630039848/post"
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
    
    func sendImg() {
        let url = "file upload rul"
        let image = UIImage(named: "")
        let imgData = image!.jpegData(compressionQuality: 0.2)!
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data("value".utf8), withName: "key")
            multipartFormData.append(imgData, withName: "key", fileName: "a.jpg", mimeType: "image/jpg")
        }, to: url).responseJSON { response in
            print(response)
        }
        
        let fileURL = Bundle.main.url(forResource: "video", withExtension: "mov")

        AF.upload(fileURL!, to: "https://httpbin.org/post")
            .uploadProgress { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
    }

}
