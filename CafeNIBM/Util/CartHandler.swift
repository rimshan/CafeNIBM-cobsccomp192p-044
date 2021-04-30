//
//  CartHandler.swift
//  CafeNIBM
//
//  Created by Rimshan on 4/29/21.
//  Copyright © 2021 Rimshan. All rights reserved.
//

import Foundation


class CartHandler{
    static var foodItems: [FoodItem] = []
    
    static func getCartItems() -> [FoodItem]{
        return foodItems
    }
    
    static func clearCart() {
        self.foodItems.removeAll()
    }
}
