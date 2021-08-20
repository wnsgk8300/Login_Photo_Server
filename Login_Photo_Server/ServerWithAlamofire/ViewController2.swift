//
//  ViewController2.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/19.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit


class ViewController2: UIViewController {
    
    let nameLabel = UILabel()
    let messageLabel = UILabel()
    let getButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setUI()
        setDetail()
    }
}

//Function
extension ViewController2 {
    @objc
    func getButtonClicked(_ sender: Any) {
        
        // GetPersonDataService 구조체에서 shared라는 공용 인스턴스에 접근 -> 싱글턴
        // 그리고 만들어둔 getPersonInfo 메서드 사용
        GetPersonDataService.shared.getPersonInfo { (response) in
            // NetworkResult형 enum값을 이용해서 분기처리
            switch(response) {
            // 성공할 경우에느 <T>형으로 데이터를 받아롷 수 있다고 했기 때문에 Generic하게 아무 타입이나 가능하기 때문에
            // 클로저에서 넘어오는 데이터르 let personData라고 정의함
            case .success(let personData):
                // personData를 Person형이라고 옵셔널 바인딩 해주고, 정상적으로 값을 data에 담아둠
                if let data = personData as? Person {
                    self.nameLabel.text = data.name
                    self.messageLabel.text = data.profileMessage
                }
            //실패할 경우 분기처리
            case .requestErr(let message) :
                print("requestErr", message)
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}

// Layout
extension ViewController2 {
    func setDetail() {
        [nameLabel, messageLabel].forEach {
            $0.text = "Label"
            $0.textAlignment = .center
        }
        getButton.setTitle("GET", for: .normal)
        getButton.backgroundColor = .red
        getButton.addTarget(self, action: #selector(getButtonClicked(_:)), for: .touchUpInside)
    }
    func setUI() {
        [nameLabel, messageLabel, getButton].forEach {
            view.addSubview($0)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(50)
            $0.width.equalTo(nameLabel)
            $0.centerX.equalTo(nameLabel)
        }
        getButton.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(100)
            $0.width.equalTo(nameLabel)
            $0.centerX.equalTo(nameLabel)
        }
    }
}
