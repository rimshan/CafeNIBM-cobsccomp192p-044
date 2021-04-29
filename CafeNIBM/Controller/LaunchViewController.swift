//
//  LaunchViewController.swift
//  CafeNIBM
//
//  Created by Rimshan on 4/29/21.
//  Copyright © 2021 Rimshan. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    let sessionMGR = SessionManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if sessionMGR.getLoggedState(){
            self.performSegue(withIdentifier: "LaunchToHome", sender: nil)
        }else{
            self.performSegue(withIdentifier: "LaunchToSignIn", sender: nil)
        }
    }

}
