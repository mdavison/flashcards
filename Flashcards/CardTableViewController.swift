//
//  CardTableViewController.swift
//  Flashcards
//
//  Created by Morgan Davison on 10/28/15.
//  Copyright © 2015 Morgan Davison. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController, CardDetailTableViewControllerDelegate {

    var deck: Deck!
    
    struct Storyboard {
        static let reuseIdentifier = "Card"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = deck.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deck.cards.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.reuseIdentifier, forIndexPath: indexPath)

        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = deck.cards[indexPath.row].frontText

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            deck.cards.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - CardDetailTableViewControllerDelegate
    
    func cardDetailTableViewControllerDidCancel(controller: CardDetailTableViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cardDetailTableViewController(controller: CardDetailTableViewController, didFinishAddingCard card: Card) {
        let newRowIndex = deck.cards.count
        deck.cards.append(card)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)

        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cardDetailTableViewController(controller: CardDetailTableViewController, didFinishEditingCard card: Card) {
        if let index = deck.cards.indexOf(card) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                let label = cell.viewWithTag(1000) as! UILabel
                
                label.text = deck.cards[indexPath.row].frontText
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowCard" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let frontViewController = navigationController.topViewController as! FrontViewController
            
            if let selectedCardCell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCardCell)!
                let selectedCard = deck.cards[indexPath.row]
                frontViewController.card = selectedCard
                frontViewController.deck = deck 
                //frontViewController.cards = deck.cards
            }
        } else if segue.identifier == "AddCard" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! CardDetailTableViewController
            controller.delegate = self
        } else if segue.identifier == "EditCard" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! CardDetailTableViewController
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.cardToEdit = deck.cards[indexPath.row]
            }
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func backToDeckUnwindSegue(unwindSegue: UIStoryboardSegue) {
    }
    
    
}
