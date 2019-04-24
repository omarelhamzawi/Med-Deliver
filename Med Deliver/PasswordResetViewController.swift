//
//  PasswordResetViewController.swift
//  Med Deliver
//
//  Created by Omar El-Hamzawi on 11/03/2019.
//  Copyright © 2019 Omar Elhamzawi. All rights reserved.
//

import UIKit

class PasswordResetViewController: UIViewController {
    @IBOutlet weak var EmailAddressTextField: UITextField!
    
    @IBAction func RegisterHereButtonTapped(_ sender: Any) {
        print ("Register Here button tapped")
    }
    @IBAction func BackButtonTapped(_ sender: Any) {
        print ("Back button tapped")
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
