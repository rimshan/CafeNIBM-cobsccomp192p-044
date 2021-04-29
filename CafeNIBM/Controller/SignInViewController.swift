//
//  SignInViewController.swift
//  CafeNIBM
//
//  Created by Rimshan on 4/27/21.
//  Copyright © 2021 Rimshan. All rights reserved.
//

import UIKit
import Firebase
import Loaf

class SignInViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    @IBAction func onSignInPressed(_ sender: UIButton) {
        if validateInput(){
            authenticateUser(email: txtEmail.text!, password: txtPassword.text!)
        }else{
            print("Input Validation Failed")
        }
    }
    
    func validateInput() -> Bool {
        guard let email = txtEmail.text else {
            print("Email is required")
            return false
        }
        guard let password = txtPassword.text else{
            print("Password is required")
            return false
        }
        if email.count < 5 {
            print("Enter a valid Email")
            return false
        }
        if password.count < 5 {
            
        }
        return true
        
    }
    
    func authenticateUser(email: String, password: String)  {
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
        
            if let err = error{
                print(err.localizedDescription)
                Loaf("User name or password ivalid", state: .error, sender:self).show()
                return
            }
            
            //save_user_logged_in_state
            
            let sessionManager = SessionManager()
            sessionManager.saveUserLogin()
            self.performSegue(withIdentifier: "SignInToHome", sender: nil)
        }
    }
}
