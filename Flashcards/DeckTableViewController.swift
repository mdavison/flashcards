//
//  DeckTableViewController.swift
//  Flashcards
//
//  Created by Morgan Davison on 11/9/15.
//  Copyright © 2015 Morgan Davison. All rights reserved.
//

import UIKit

class DeckTableViewController: UITableViewController, DeckDetailTableViewControllerDelegate, UINavigationControllerDelegate {
    
    var dataModel: DataModel!
    
    struct Storyboard {
        static let ReuseIdentifier = "Cell"
        static let ShowDeckSegue = "ShowDeck"
        static let AddDeckSegue = "AddDeck"
        static let DeckDetailNavigationControllerIdentifier = "DeckDetailNavigationController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        
        let index = dataModel.indexOfSelectedDeck
        if index >= 0 && index < dataModel.decks.count {
            let deck = dataModel.decks[index]
            performSegueWithIdentifier(Storyboard.ShowDeckSegue, sender: deck)
            
        }
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
        return dataModel.decks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cellForTableView(tableView)
        
        let deck = dataModel.decks[indexPath.row]
        cell.textLabel!.text = deck.name
        cell.accessoryType = .DetailDisclosureButton
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.indexOfSelectedDeck = indexPath.row
        
        let deck = dataModel.decks[indexPath.row]
        performSegueWithIdentifier(Storyboard.ShowDeckSegue, sender: deck)
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
            dataModel.decks.removeAtIndex(indexPath.row)
            
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
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController = storyboard!.instantiateViewControllerWithIdentifier(Storyboard.DeckDetailNavigationControllerIdentifier) as! UINavigationController
        let controller = navigationController.topViewController as! DeckDetailTableViewController
        controller.delegate = self
        
        let deck = dataModel.decks[indexPath.row]
        controller.deckToEdit = deck
        
        presentViewController(navigationController, animated: true, completion: nil)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.ShowDeckSegue {
            let controller = segue.destinationViewController as! CardTableViewController
            controller.deck = sender as! Deck
        } else if segue.identifier == Storyboard.AddDeckSegue {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! DeckDetailTableViewController
            controller.delegate = self
            controller.deckToEdit = nil
        }
    }
    
    private func cellForTableView(tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.ReuseIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: Storyboard.ReuseIdentifier)
        }
    }
    
    
    // MARK: - DeckDetailTableViewControllerDelegate
    
    func deckDetailTableViewControllerDidCancel(controller: DeckDetailTableViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func deckDetailTableViewController(controller: DeckDetailTableViewController, didFinishAddingDeck deck: Deck) {
        let newRowIndex = dataModel.decks.count
        
        dataModel.decks.append(deck)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func deckDetailTableViewController(controller: DeckDetailTableViewController, didFinishEditingDeck deck: Deck) {
        if let index = dataModel.decks.indexOf(deck) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                cell.textLabel!.text = deck.name
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: UINavigationControllerDelegate
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController === self {
            dataModel.indexOfSelectedDeck = -1
        }
    }


}
