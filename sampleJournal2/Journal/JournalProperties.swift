//
//  JournalProperties.swift
//  599 Prototype
//
//  Created by Raza Qazi on 2017-11-18.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import Foundation
import os.log

class JournalProperties: NSObject, NSCoding {
    
    var journalEntry: String = ""
    var date: String = ""
    var time: String = ""
    var location: (longitude: Double, latitude: Double)? = nil
    var sentiment: (String, String, String) = ("", "", "")
    
    
    // Property Keys
    struct PropertyKey {
        static let journalEntry = "journalEntry"
        static let date = "date"
        static let time = "time"
        static let location = "location"
        static let sentiment = "sentiment"
    }
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("journals")
    
    
    init?(_ journal:String, _ date: String, _ time: String, _ location: (Double, Double), _ sentiment: (String, String, String)) {
        self.journalEntry = journal
        self.date = date
        self.time = time
        self.location = location
        self.sentiment = sentiment
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(journalEntry, forKey: PropertyKey.journalEntry)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(time, forKey: PropertyKey.time)
        aCoder.encode(location, forKey: PropertyKey.location)
        aCoder.encode(sentiment, forKey: PropertyKey.sentiment)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The journal Entry is required. If we cannot decode a name string, the initializer should fail.
        guard let journalEntry = aDecoder.decodeObject(forKey: PropertyKey.journalEntry) as? String else {
            os_log("Unable to decode the journal entry for a JournalProperties object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else {
            os_log("Unable to decode the journal date for a JournalProperties object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let time = aDecoder.decodeObject(forKey: PropertyKey.time) as? String else {
            os_log("Unable to decode the journal time for a JournalProperties object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let sentiment = aDecoder.decodeObject(forKey: PropertyKey.sentiment) as? (String, String, String) else {
            os_log("Unable to decode the journal sentiment for a JournalProperties object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? (longitude: Double, latitude: Double) else {
            os_log("Unable to decode the journal location for a JournalProperties object.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(journalEntry, date, time, location, sentiment)
    }
}
