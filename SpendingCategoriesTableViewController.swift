//
//  SpendingCategoriesTableViewController.swift
//  Rewards Maximizer
//
//  Created by Ryan MORGAN on 3/16/19.
//  Copyright © 2019 Ryan MORGAN. All rights reserved.
//

import UIKit

class SpendingCategoriesTableViewController: UITableViewController {

    var creditCards: [CreditCard] = []
    var availableCategories = [CreditCard.RewardsCategory]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
        tableView.reloadData()
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
       
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        return availableCategories.count
        
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCellTableViewCell
        
        let category = availableCategories[indexPath.row]
        cell.categoryLabel?.text = category.rawValue
        switch category {
        case .allSpending:
            cell.backgroundColor = .blue
            cell.categoryLabel.textColor = .white
        case .dining:
            cell.backgroundColor = .orange
        case .travel:
            cell.backgroundColor = .yellow
        case .gas:
            cell.backgroundColor = .purple
            cell.categoryLabel.textColor = .white
        case .groceries:
            cell.backgroundColor = .red
            cell.categoryLabel.textColor = .white
        case .amazon:
            cell.backgroundColor = .green
        default:
            cell.backgroundColor = tableView.backgroundColor
        }
        
        if category == .allSpending {
            cell.backgroundColor = .blue
        }
       

        return cell
    }
    
    
    
    func updateData() {
        if let savedCreditCards = CreditCard.loadCreditCards() {
            creditCards = savedCreditCards
        } else {
            creditCards = CreditCard.loadSampleCreditCards()
        }
        
        
        for creditCard in creditCards {
            for key in creditCard.rewardsDict.keys {
                if !availableCategories.contains(key) {
                    availableCategories.append(key)
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "showBestCard" else {return}
        let destinationViewController = segue.destination as! BestCardForCategoryViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        let selectedCategory = availableCategories[selectedIndexPath.row]
        destinationViewController.category = selectedCategory
    }
     

   
}
