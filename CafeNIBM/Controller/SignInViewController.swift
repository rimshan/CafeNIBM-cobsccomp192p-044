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
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
      
    }

    @IBAction func onSignInPressed(_ sender: UIButton) {
        
        if !InputValidator.isValidEmail(email: txtEmail.text ?? ""){
            Loaf("Invalid email address", state: .error, sender:self).show()
            return
        }
        
        if !InputValidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6, maxLength: 50){
            Loaf("Invalid password", state: .error, sender:self).show()
            return
        }
        
        authenticateUser(email: txtEmail.text!, password: txtPassword.text!)
        
    }
    
    
    func authenticateUser(email: String, password: String)  {
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
        
            if let err = error{
                print(err.localizedDescription)
                Loaf("User name or password ivalid", state: .error, sender:self).show()
                return
            }
            
            if let email = authResult?.user.email{
                self.getUserData(email: email)
            }else{
                 Loaf("User not found", state: .error, sender:self).show()
            }
            
            //save_user_logged_in_state
            
//            let sessionManager = SessionManager()
//            sessionManager.saveUserLogin()
            
        }
    }
    
    func getUserData(email: String){
        ref.child("users")
        .child(email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")).observe(.value, with: {
                (snapshot) in
                
                if snapshot.hasChildren(){
                    if let data = snapshot.value{
                        if let userdata = data as? [String: String]{
                            let user = User(
                                userName: userdata["userName"]!,
                                userEmail: userdata["userEmail"]!,
                                userPassword: userdata["userPassword"]!,
                                userPhone: userdata["userPhone"]!)
                            let sessionMGR = SessionManager()
                            sessionMGR.saveUserLogin(user: user)
                            self.performSegue(withIdentifier: "SignInToHome", sender: nil)
                        }
                    }
                }else{
                     Loaf("User not found", state: .error, sender:self).show()
                }
            })
    }
}
