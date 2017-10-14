//
//  LoginViewController.swift
//  chatBuddy
//
//  Created by Ammy Pandey on 11/10/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginBtn(_ sender: UIButton) {
       // let email = "test@gmail.com"
        //let password = "123456"
        
        FirebaseManager.Login(email: emailTxt.text!, password: passwordTxt.text!) { (success:Bool) in
            if success {
                self.performSegue(withIdentifier: "showProfile", sender: self)
            }
        }
        
    }
    @IBAction func signUp(_ sender: UIButton) {
        FirebaseManager.createUser(username: usernameTxt.text!, email: emailTxt.text!, password: passwordTxt.text!) {
            
            (result: String) in
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        }
    }

}
