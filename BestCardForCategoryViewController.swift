//
//  BestCardForCategoryViewController.swift
//  Rewards Maximizer
//
//  Created by Ryan MORGAN on 3/16/19.
//  Copyright © 2019 Ryan MORGAN. All rights reserved.
//

import UIKit

class BestCardForCategoryViewController: UIViewController {

    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var rewardsCategoryLabel: UILabel!
    
    @IBOutlet weak var rewardsPercentLabel: UILabel!
    
    var category: CreditCard.RewardsCategory?
    var cardsInCategory: [CreditCard] = []
    var creditCards: [CreditCard]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let category = category else {return}
        
        sortCards()
        cardNameLabel.text? = cardsInCategory[0].name
        rewardsCategoryLabel.text? = category.rawValue
        rewardsPercentLabel.text? = CreditCard.numberFormatter.string(from: cardsInCategory[0].rewardsDict[category]! as NSNumber) ?? ""
    }
    
    func sortCards() {
        if let savedCreditCards = CreditCard.loadCreditCards() {
            creditCards = savedCreditCards
        } else {
            creditCards = CreditCard.loadSampleCreditCards()
        }
        
        cardsInCategory = []
        
        for creditCard in creditCards! {
                for key in creditCard.rewardsDict.keys {
                    if key == category {
                        cardsInCategory.append(creditCard)
                    }
                }
        }
        
        cardsInCategory.sorted { $0.rewardsDict[category!]! > $1.rewardsDict[category!]! }
   
    }

    
    
    
}
