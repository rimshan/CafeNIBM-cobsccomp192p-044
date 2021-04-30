//
//  CartViewController.swift
//  CafeNIBM
//
//  Created by Rimshan on 4/29/21.
//  Copyright © 2021 Rimshan. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tblCartItems: UITableView!
    
    var cartItems: [FoodItem] = [] 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartItems = CartHandler.getCartItems()
        tblCartItems.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReuseIdentifier")
    }
    

    @IBAction func onConfirmPressed(_ sender: Any) {
    }
    

    @IBAction func onBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
