//
//  SignUpViewController.swift
//  CafeNIBM
//
//  Created by Rimshan on 4/28/21.
//  Copyright © 2021 Rimshan. All rights reserved.
//

import UIKit
import Firebase
import Loaf

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onSignInPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSignUpPressed(_ sender: UIButton) {
        if validateInput(){
            registerUser(email: txtEmail.text!, password: txtPassword.text!)
        }else{
            print("Input validatation failed")
        }
    }
    
    func registerUser(email: String, password:String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error{
                print(err.localizedDescription)
                Loaf("User sign up failed", state: .error, sender:self).show()
                return
            }
            
            if let result = authResult{
                Loaf("User registered successfully", state: .success, sender:self).show()
                print("User registered successfully with  email :\(result.user.email ?? "Not Found")")
            }
        }
    }
    
    func validateInput() -> Bool{
        guard let name = txtPassword.text else {
            print("Name is required")
            return false
        }
        
        guard let email = txtEmail.text else{
            print("Email is required")
            return false
        }
        
        guard let phone = txtPhone.text else {
            print("Phone is required")
            return false
        }
        
        guard let password = txtPassword.text else{
            print("Password is required")
            return false
        }
        
        if name.count < 5 {
            print("Enter valid name")
            return false
        }
        if email.count < 5 {
            print("Enter valid email")
            return false
        }
        if phone.count < 10 {
            print("Enter valid phone number")
            return false
        }
        if password.count < 5 {
            print("Enter strong password")
            return false
        }
        
        return true
        
      
        
    }
}
