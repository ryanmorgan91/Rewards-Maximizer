//
//  CreditCards.swift
//  Rewards Maximizer
//
//  Created by Ryan MORGAN on 3/3/19.
//  Copyright © 2019 Ryan MORGAN. All rights reserved.
//

import Foundation

class CreditCard: Codable {
    var name: String
    var rewardsDict: [RewardsCategory: Double]
    
    enum RewardsCategory: String, Codable, CaseIterable {
        case allSpending = "All Spending"
        case dining = "Dining"
        case travel = "Travel"
        case gas = "Gas"
        case groceries = "Groceries"
        case amazon = "Amazon"
    }
    
    static let allRewardsCategoriesArray = RewardsCategory.allCases
  
    init(name: String, rewardsDict: [RewardsCategory: Double]) {
        self.name = name
        self.rewardsDict = rewardsDict
    }
    
    static func loadSampleCreditCards() -> [CreditCard] {
        let sampleCreditCard1 = CreditCard(name: "Citi Double Cash", rewardsDict: [.allSpending: 0.02])
        let sampleCreditCard2 = CreditCard(name: "AmEx Blue Cash", rewardsDict: [.groceries: 0.03])
        let sampleCreditCard3 = CreditCard(name: "Amazon Chase Card", rewardsDict: [.amazon: 0.05])
      
        
        return [sampleCreditCard1, sampleCreditCard2]
    }
    
    static func loadCreditCards() -> [CreditCard]? {
        guard let codedCreditCards = try? Data(contentsOf: ArchiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<CreditCard>.self, from: codedCreditCards)
    }
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("creditCards").appendingPathExtension("plist")
    
    static func saveCreditCards(_ creditCards: [CreditCard]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedCreditCards = try? propertyListEncoder.encode(creditCards)
        try? codedCreditCards?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
}

