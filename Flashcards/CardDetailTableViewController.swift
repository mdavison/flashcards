//
//  CardDetailTableViewController.swift
//  Flashcards
//
//  Created by Morgan Davison on 10/28/15.
//  Copyright © 2015 Morgan Davison. All rights reserved.
//

import UIKit

protocol CardDetailTableViewControllerDelegate: class {
    func cardDetailTableViewControllerDidCancel(controller: CardDetailTableViewController)
    func cardDetailTableViewController(controller: CardDetailTableViewController, didFinishAddingCard card: Card)
    func cardDetailTableViewController(controller: CardDetailTableViewController, didFinishEditingCard card: Card)
}

class CardDetailTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var frontTextField: UITextField!
    @IBOutlet weak var backTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    weak var delegate: CardDetailTableViewControllerDelegate?
    var cardToEdit: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let card = cardToEdit {
            title = "Edit Card"
            frontTextField.text = card.frontText
            backTextField.text = card.backText
            saveButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        frontTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    
    // MARK: - UITextFieldDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        saveButton.enabled = (newText.length > 0)
        
        return true 
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions
    @IBAction func cancel() {
        delegate?.cardDetailTableViewControllerDidCancel(self)
    }
    
    @IBAction func save() {
        if let card = cardToEdit {
            card.frontText = frontTextField.text!
            card.backText = backTextField.text!
            delegate?.cardDetailTableViewController(self, didFinishEditingCard: card)
        } else {
            let card = Card()
            card.frontText = frontTextField.text!
            card.backText = backTextField.text!
            
            delegate?.cardDetailTableViewController(self, didFinishAddingCard: card)
        }
    }

}
