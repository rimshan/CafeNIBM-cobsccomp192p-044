//
//  FoodItemViewController.swift
//  CafeNIBM
//
//  Created by Rimshan on 4/29/21.
//  Copyright © 2021 Rimshan. All rights reserved.
//

import UIKit
import Kingfisher

class FoodItemViewController: UIViewController {

    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    
    var foodItem : FoodItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = self.foodItem{
            imgFood.kf.setImage(with: URL(string: item.image))
            lblFoodName.text = item.foodName
            lblFoodDescription.text = item.foodDescription
            lblFoodPrice.text = "LKR: \(item.foodPrice)"
        }
    }
    

    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAddToCart(_ sender: UIButton) {
        if let item = self.foodItem {
            CartHandler.foodItems.append(item)
        }
        
        print(CartHandler.foodItems)
    }
}
