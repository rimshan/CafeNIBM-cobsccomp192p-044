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
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    
    @IBAction func onSignInPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSignUpPressed(_ sender: UIButton) {
        
        
        if !InputValidator.isValidName(name: txtName.text ?? ""){
            Loaf("Invalid name", state: .error, sender:self).show()
            return
        }
            
            
        if !InputValidator.isValidEmail(email: txtEmail.text ?? ""){
            Loaf("Invalid email address", state: .error, sender:self).show()
            return
        }
               
        if !InputValidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6, maxLength: 50){
            Loaf("Invalid password", state: .error, sender:self).show()
            return
        }
        
        if !InputValidator.isValidMobileNo(txtPhone.text ?? ""){
            Loaf("Invalid phone number", state: .error, sender:self).show()
            return
        }
        
        let user = User(userName: txtName.text ?? "", userEmail: txtEmail.text ?? "", userPassword: txtPassword.text ?? "", userPhone: txtPhone.text ?? "")
        
        registerUser(user: user)
        

    }
    
    func registerUser(user: User){
        Auth.auth().createUser(withEmail: user.userEmail, password: user.userPassword) { authResult, error in
            if let err = error{
                print(err.localizedDescription)
                Loaf("User sign up failed", state: .error, sender:self).show()
                return
            }
            
            self.saveUserData(user: user)
            
        }
    }
    
    func saveUserData(user: User){
        
        let userData = [
            "userName" : user.userName,
            "userEmail" : user.userEmail,
            "userPhone" : user.userPhone,
            "userPassword" : user.userPassword
        ]

        self.ref.child("users")
            .child(user.userEmail
                .replacingOccurrences(of: "@", with: "_")
                .replacingOccurrences(of: ".", with: "_"))
        .setValue(userData){
            (error, ref) in
           if let err = error{
             print(err.localizedDescription)
             Loaf("User data not save on database failed", state: .error, sender:self).show()
             return
           }
            
            Loaf("User data saveed on database", state: .success, sender:self).show{
                type in
                self.dismiss(animated: true, completion: nil)
            }
        }
       
        
    }
    
}
