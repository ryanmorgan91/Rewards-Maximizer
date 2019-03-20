//
//  CreditCardsTableViewController.swift
//  Rewards Maximizer
//
//  Created by Ryan MORGAN on 3/3/19.
//  Copyright © 2019 Ryan MORGAN. All rights reserved.
//

import UIKit

class CreditCardsTableViewController: UITableViewController {
    
    struct PropertyKeys {
        static let creditCardCellIdentifier = "CreditCardsCell"
    }
    
    var creditCards: [CreditCard] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedCreditCards = CreditCard.loadCreditCards() {
            creditCards = savedCreditCards
        } else {
            creditCards = CreditCard.loadSampleCreditCards()
            
        }

    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return creditCards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCardsCell", for: indexPath)
        cell.textLabel?.text = creditCards[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            creditCards.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            CreditCard.saveCreditCards(creditCards)
        }
    }


    @IBAction func unwindToCreditCardList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! AddEditCardTableViewController
        
        if let creditCard = sourceViewController.creditCard {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                creditCards[selectedIndexPath.row] = creditCard
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: creditCards.count, section: 0)
                creditCards.append(creditCard)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
        }
        CreditCard.saveCreditCards(creditCards)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let addEditCreditCardViewController = segue.destination as! AddEditCardTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedCreditCard = creditCards[indexPath.row]
            addEditCreditCardViewController.creditCard = selectedCreditCard
        }
    }
    
  

}
