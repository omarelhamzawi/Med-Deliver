//
//  Pharmacy.swift
//  Med Deliver
//
//  Created by Omar Elhamzawi on 27/03/2019.
//  Copyright © 2019 Omar Elhamzawi. All rights reserved.
//

import UIKit
import WebKit
class Pharmacy: UIViewController, WKNavigationDelegate {
var webView: WKWebView!
    
    //link the web view to this swift file.
    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
        // Do any additional setup after loading the view.
        
        
    
    
  
    
    
    override func viewDidLoad() {
           super.viewDidLoad()

            let url = URL(string: "https://google.com")!
            webView.load(URLRequest(url:url))
            webView.allowsBackForwardNavigationGestures = true
    }
}
