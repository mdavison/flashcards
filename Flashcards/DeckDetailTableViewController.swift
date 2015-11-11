//
//  DeckDetailTableViewController.swift
//  Flashcards
//
//  Created by Morgan Davison on 11/9/15.
//  Copyright © 2015 Morgan Davison. All rights reserved.
//

import UIKit

protocol DeckDetailTableViewControllerDelegate: class {
    func deckDetailTableViewControllerDidCancel(controller: DeckDetailTableViewController)
    func deckDetailTableViewController(controller: DeckDetailTableViewController, didFinishAddingDeck deck: Deck)
    func deckDetailTableViewController(controller: DeckDetailTableViewController, didFinishEditingDeck deck: Deck)
}

class DeckDetailTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    weak var delegate: DeckDetailTableViewControllerDelegate?
    var deckToEdit: Deck? 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let deck = deckToEdit {
            title = "Edit Deck"
            textField.text = deck.name
            saveBarButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    
    // MARK: - Text field delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        saveBarButton.enabled = (newText.length > 0)
        
        return true 
    }
    
    
    // MARK: - Actions
   
    @IBAction func cancel() {
        delegate?.deckDetailTableViewControllerDidCancel(self)
    }
    
    @IBAction func save() {
        if let deck = deckToEdit {
            deck.name = textField.text!
            delegate?.deckDetailTableViewController(self, didFinishEditingDeck: deck)
        } else {
            let deck = Deck(name: textField.text!)
            delegate?.deckDetailTableViewController(self, didFinishAddingDeck: deck)
        }
    }
}
