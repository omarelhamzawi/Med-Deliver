//
//  Pharmacy.swift
//  Med Deliver
//
//  Created by Omar Elhamzawi on 27/03/2019.
//  Copyright © 2019 Omar Elhamzawi. All rights reserved.
//

import UIKit
class Pharmacy: UIViewController{
    
    //link the web view to this swift file.
    
    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // PREREQUISTE: make sure to update the URL to the correct file directory !
        
        
        //REMEMBER TO CHANGE THE URL ! ! !
        
        let url = URL(string: "file:///Users/supathshrestha/Desktop/MED%20DELIVER/Med%20Deliver/MED%20DELIVER%20APP/checkout/index.html")
        myWebView.loadRequest(URLRequest(url: url!))
    }
  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
