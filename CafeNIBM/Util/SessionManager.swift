//
//  SessionManager.swift
//  CafeNIBM
//
//  Created by Rimshan on 4/28/21.
//  Copyright © 2021 Rimshan. All rights reserved.
//

import Foundation

class SessionManager {
    
    func getLoggedState() ->Bool{
       return UserDefaults.standard.bool(forKey: "USER_LOGGED")
    }
    
    func saveUserLogin(){
         UserDefaults.standard.setValue(true, forKey: "USER_LOGGED")
    }
    
    func clearUserLoggedState(){
        UserDefaults.standard.setValue(false, forKey: "USER_LOGGED")
    }
}
