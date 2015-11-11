//
//  Deck.swift
//  Flashcards
//
//  Created by Morgan Davison on 11/9/15.
//  Copyright © 2015 Morgan Davison. All rights reserved.
//

import UIKit

class Deck: NSObject, NSCoding {
    
    var name = ""
    var cards = [Card]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        cards = aDecoder.decodeObjectForKey("Cards") as! [Card]
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(cards, forKey: "Cards")
    }
    
    func truncateNameToLength(length: Int) -> String {
        if name.characters.count > length {
            var truncatedName = ""
            for index in name.characters.indices {
                truncatedName.append(name.characters[index])
                if truncatedName.characters.count > length {
                    truncatedName += "..."
                    return truncatedName
                }
            }
        }
        
        return name 
    }
}
