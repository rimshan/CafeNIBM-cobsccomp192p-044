//
//  CartViewController.swift
//  CafeNIBM
//
//  Created by Rimshan on 4/29/21.
//  Copyright © 2021 Rimshan. All rights reserved.
//

import UIKit
import Firebase
import Loaf

class CartViewController: UIViewController {

    @IBOutlet weak var tblCartItems: UITableView!
    
    var ref: DatabaseReference!
    
    var cartItems: [FoodItem] = []
    let sessionMGR = SessionManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.cartItems = CartHandler.getCartItems()
        tblCartItems.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReuseIdentifier")
    }
    

    @IBAction func onConfirmPressed(_ sender: Any) {
        saveOrder()
    }
    

    @IBAction func onBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CartViewController{
    func saveOrder(){
        
        var orderData : [String: Any] = [:]
        var foodItemInfo : [String: Any] = [:]
        
        for index in 0..<cartItems.count {
            foodItemInfo.removeAll()
            foodItemInfo["foodName"] = cartItems[index].foodName
            foodItemInfo["foodDescription"] = cartItems[index].foodDescription
            foodItemInfo["foodPrice"] = cartItems[index].foodPrice
            orderData["\(index)"] = foodItemInfo
        }
        
        self.ref.child("orders")
            .child(sessionMGR.getUserData().userEmail
                   .replacingOccurrences(of: "@", with: "_")
                   .replacingOccurrences(of: ".", with: "_"))
        .childByAutoId()
           .setValue(orderData){
               (error, ref) in
              if let err = error{
                print(err.localizedDescription)
                Loaf("Order data save on database failed", state: .error, sender:self).show()
                return
              }
               
               Loaf("Order data saved on database", state: .success, sender:self).show{
                   type in
                 
                CartHandler.clearCart()
                   self.dismiss(animated: true, completion: nil)
               }
           }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tblCartItems.dequeueReusableCell(withIdentifier: "FoodCellReuseIdentifier", for: indexPath) as! FoodTableViewCell
           cell.setupView(foodItem: cartItems[indexPath.row])
           return cell
       }
    
    
}
