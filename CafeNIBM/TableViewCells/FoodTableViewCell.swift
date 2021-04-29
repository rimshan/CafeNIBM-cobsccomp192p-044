//
//  FoodTableViewCell.swift
//  CafeNIBM
//
//  Created by Rimshan on 4/28/21.
//  Copyright © 2021 Rimshan. All rights reserved.
//

import UIKit
import Kingfisher

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContainerDiscount: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(foodItem: FoodItem){
        lblFoodName.text = foodItem.foodName
        lblFoodDescription.text = foodItem.foodDescription
        lblFoodPrice.text = "LKR \(foodItem.foodPrice)"
        imgFood.kf.setImage(with: URL(string: foodItem.image))
        
        if foodItem.discount > 0 {
            lblDiscount.isHidden = false
            lblDiscount.text = "\(foodItem.discount)%"
        }else{
            lblDiscount.isHidden = true
            lblDiscount.text = ""
        }
    }
    
}
