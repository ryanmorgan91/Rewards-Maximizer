//
//  CreditCardsTableViewCell.swift
//  Rewards Maximizer
//
//  Created by Ryan MORGAN on 3/9/19.
//  Copyright © 2019 Ryan MORGAN. All rights reserved.
//

import UIKit

class CreditCardsTableViewCell: UITableViewCell {

    @IBOutlet weak var creditCardNameLabel: UILabel!
    @IBOutlet weak var creditCardCategoryOneLabel: UILabel!
    @IBOutlet weak var creditCardCategoryOnePercentLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func update(with creditCard: CreditCard) {
        creditCardNameLabel.text = creditCard.name
        var creditCardRewardsArrayKeys = [CreditCard.RewardsCategory](creditCard.rewardsDict.keys)
        creditCardCategoryOneLabel.text = creditCardRewardsArrayKeys[0].rawValue
        
        
        creditCardCategoryOnePercentLabel.text = CreditCard.numberFormatter.string(from: creditCard.rewardsDict[creditCardRewardsArrayKeys[0]]! as NSNumber)

   }
    
}
