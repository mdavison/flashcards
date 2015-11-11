//
//  Card.swift
//  Flashcards
//
//  Created by Morgan Davison on 10/28/15.
//  Copyright © 2015 Morgan Davison. All rights reserved.
//

import Foundation

class Card: NSObject, NSCoding {
    
    var frontText: String?
    var backText: String?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        frontText = aDecoder.decodeObjectForKey("FrontText") as? String
        backText = aDecoder.decodeObjectForKey("BackText") as? String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(frontText, forKey: "FrontText")
        aCoder.encodeObject(backText, forKey: "BackText")
    }
    
}