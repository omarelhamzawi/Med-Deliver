//
//  ViewController.swift
//  Med Deliver
//
//  Created by Supath Shrestha on 17/10/2018.
//  Copyright © 2018 Supath Shrestha. All rights reserved.
//

import UIKit

var name = ""

class ViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            
            registerButton.layer.cornerRadius = registerButton.frame.size.height/2
            registerButton.layer.masksToBounds = true
        
            signInButton.layer.cornerRadius = registerButton.frame.size.height/2
            signInButton.layer.masksToBounds = true
        
            view.setGradientBackground(colorOne: Colors.white, colorTwo: Colors.green)
            signInButton.setGradientBackground(colorOne: Colors.orange, colorTwo: Colors.brightOrange)
            registerButton.setGradientBackground(colorOne: Colors.orange, colorTwo: Colors.brightOrange)
        }
        
}


