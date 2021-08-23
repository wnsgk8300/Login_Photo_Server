//
//  ViewController4.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/23.
//

import UIKit
import Alamofire
import SnapKit

class ViewController4: UIViewController {
    
    let button = UIButton()
    let label = UILabel()
    let searchBar = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        view.backgroundColor = .red
        setDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //인증 실패 notification 등록
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorPopup(notification:)), name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //인증 노티피케이션 등록 해제
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    @objc
    func showErrorPopup(notification: NSNotification) {
        print("VC - show Error popup()")
        
        if let data = notification.userInfo?["statusCode"] {
            print("showErrorPopup() data: \(data)")
            
            
        }
    }
    
    @objc
    func onButtonClicked(_ sender: UIButton) {
//        AF.request("https://api.unsplash.com/search/photos").response { response in debugPrint(response)}
        
//        let url = API.BASE_URL + "search/photos"
//
        guard let userInput = self.searchBar.text else {
            return
        }
//        let queryParam = ["query": userInput, "client_id": API.CLIENT_ID]
        
        //completioHandler - 완료가 되면 비동기로 들어오게됨
//        AF.request(url, method: .get, parameters: queryParam).responseJSON(completionHandler: { response in debugPrint(response)})
        
        MyAlamofireManager
            .shared
            .session
            .request(MySearchRouter.searchPhotos(term: userInput))
            //validate가 추가돼서 BaseInterceptor의 retry가 호출됨
            .validate(statusCode: 200...400)
            .responseJSON(completionHandler: { response in
//                                                                     debugPrint(response)
            
        })
    }
    
    func setDetail() {
        button.setTitle("Alamofire", for: .normal)
        button.addTarget(self, action: #selector(onButtonClicked(_:)), for: .touchUpInside)
     
        searchBar.placeholder = "입력해봐"
        searchBar.backgroundColor = .white
    }
    
    func setUI() {
        [button, label, searchBar].forEach {
            view.addSubview($0)
        }
        button.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(50)
        }
        searchBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(button.snp.top).offset(-100)
            $0.width.equalTo(200)
        }
    }
}

