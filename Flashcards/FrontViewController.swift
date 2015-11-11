//
//  FrontViewController.swift
//  Flashcards
//
//  Created by Morgan Davison on 10/27/15.
//  Copyright © 2015 Morgan Davison. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var deckButton: UIBarButtonItem!
    
    var card: Card?
    var deck: Deck?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deckButton.title = deck?.truncateNameToLength(10)
        
        if let card = card {
            label.text = card.frontText
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowCardBack" {
            let backViewController = segue.destinationViewController as! BackViewController
            backViewController.card = card
            backViewController.deck = deck 
        } 
    }

    @IBAction func nextButton(sender: UIBarButtonItem) {
        nextCard()
    }
    
    func nextCard() {
        if let index = deck!.cards.indexOf(card!) {
            var nextIndex = index + 1
            if deck!.cards.count == nextIndex {
                nextIndex = 0
            }
            card = deck!.cards[nextIndex]
            label.text = card?.frontText
        }
    }

}

