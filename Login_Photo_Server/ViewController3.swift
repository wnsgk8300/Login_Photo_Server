//
//  ViewController3.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/20.
//

import UIKit
import WebKit

class ViewController3: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    let dic: Dictionary = ["message": "OK"]
    
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let serverURL = URL(string: "http://localhost:3000")
        let request = URLRequest(url: serverURL!)
        webView.load(request)
    }

    func server() {
        guard let url = URL(string: "http://192.168.0.37:3000") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do { //request body에 전송할 데이터 넣기
            request.httpBody = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept-Type")

    }
}
