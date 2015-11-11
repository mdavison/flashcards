//
//  BackViewController.swift
//  Flashcards
//
//  Created by Morgan Davison on 10/28/15.
//  Copyright © 2015 Morgan Davison. All rights reserved.
//

import UIKit

class BackViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var deckButton: UIBarButtonItem!
    
    
    var card: Card?
    var deck: Deck?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deckButton.title = deck?.truncateNameToLength(10)

        if let card = card {
            label.text = card.backText
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowCardFront" {
            let frontViewController = segue.destinationViewController as! FrontViewController
            frontViewController.card = card
            frontViewController.deck = deck 
        }
    }
    

    

}
