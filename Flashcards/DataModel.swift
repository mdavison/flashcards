//
//  DataModel.swift
//  Flashcards
//
//  Created by Morgan Davison on 11/9/15.
//  Copyright © 2015 Morgan Davison. All rights reserved.
//

import Foundation

class DataModel {
    var decks = [Deck]()
    
    var indexOfSelectedDeck: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey("DeckIndex")
        }
        set {
            return NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "DeckIndex")
        }
    }
    
    init() {
        loadDecks()
        registerDefaults()
        handleFirstTime()
    }
    
    func saveDecks() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(decks, forKey: "Decks")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    private func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    private func dataFilePath() -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Flashcards.plist")
    }
    
    private func loadDecks() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                decks = unarchiver.decodeObjectForKey("Decks") as! [Deck]
                unarchiver.finishDecoding()
            }
        }
    }
    
    private func registerDefaults() {
        let dictionary = [ "DeckIndex": -1,
                           "FirstTime": true ]
        
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    private func handleFirstTime() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefaults.boolForKey("FirstTime")
        if firstTime {
            let deck = Deck(name: "Flashcards")
            decks.append(deck)
            indexOfSelectedDeck = 0
            userDefaults.setBool(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }

}