//
//  ProfileViewController.swift
//  CafeNIBM
//
//  Created by Rimshan on 4/29/21.
//  Copyright © 2021 Rimshan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let sessionMGR = SessionManager()
    @IBOutlet weak var txtPhone: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtUserName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = sessionMGR.getUserData()
        txtEmail.text = user.userEmail
        txtUserName.text = user.userName
        txtPhone.text = user.userPhone
    }
    

    @IBAction func onSignOutPressed(_ sender: UIButton) {
        let sessionMGR = SessionManager()
        sessionMGR.clearUserLoggedState()
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
