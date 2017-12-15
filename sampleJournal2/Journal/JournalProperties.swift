//
//  JournalProperties.swift
//  599 Prototype
//
//  This class stores the details for a journal entry.
//  Persistent storage is factored into this class.
//
//  An attribute for weather can be added in here.
//

import Foundation
import os.log

class JournalProperties: NSObject, NSCoding {
    
    var journalEntry: String = "" // Text written in journal
    var date: String = "" // Date of journal entry
    var time: String = "" // Timestamp of journal entry
    var location: (latitude: Double, longitude: Double)? = nil // Location of journal entry
    var sentiment: (String, String, String) = ("", "", "") // emotionText, emotionConfidence, emotionEmoji
    
    
    // Property Keys to define each journal element key and value
    struct PropertyKey {
        static let journalEntry = "journalEntry"
        static let date = "date"
        static let time = "time"
        
        // Property values for location tuple
        static let location_latitude = "location_latitude"
        static let location_longitude = "location_longitude"
        
        // Property values for sentiment tuple
        static let sentiment_0 = "sentiment_0"
        static let sentiment_1 = "sentiment_1"
        static let sentiment_2 = "sentiment_2"
    }
    
    //MARK: Archiving Paths to local storage locatiom
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("journals")
    
    // Object initialization when creating a new journal object
    init?(_ journal:String, _ date: String, _ time: String, _ location: (Double, Double), _ sentiment: (String, String, String)) {
        self.journalEntry = journal
        self.date = date
        self.time = time
        self.location = location
        self.sentiment = sentiment
    }
    
    // Technique to encode object properties to local storage
    func encode(with aCoder: NSCoder) {
        aCoder.encode(journalEntry, forKey: PropertyKey.journalEntry)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(time, forKey: PropertyKey.time)
        
        // Location
        aCoder.encode(location?.latitude, forKey: PropertyKey.location_latitude)
        aCoder.encode(location?.longitude, forKey: PropertyKey.location_longitude)
        
        // Sentiment
        aCoder.encode(sentiment.0, forKey: PropertyKey.sentiment_0)
        aCoder.encode(sentiment.1, forKey: PropertyKey.sentiment_1)
        aCoder.encode(sentiment.2, forKey: PropertyKey.sentiment_2)
    }
    
    // When reading from local storage, technique to decode stored data to object properties
    required convenience init?(coder aDecoder: NSCoder) {
        // The journal Entry is required. If we cannot decode a name string, the initializer should fail.
       
        // Process journal entry, time, and date to object properties
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
        
        // Process each location tuple value and store to object
        guard let location_latitude = aDecoder.decodeObject(forKey: PropertyKey.location_latitude) as? Double else {
            os_log("Unable to decode the journal entry for a JournalProperties object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let location_longitude = aDecoder.decodeObject(forKey: PropertyKey.location_longitude) as? Double else {
            os_log("Unable to decode the journal entry for a JournalProperties object.", log: OSLog.default, type: .debug)
            return nil
        }
        let location = (location_latitude, location_longitude)
        
        // Process each sentiment variant and store to object
        guard let sentiment_0 = aDecoder.decodeObject(forKey: PropertyKey.sentiment_0) as? String else {
            os_log("Unable to decode the journal sentiment for a JournalProperties object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let sentiment_1 = aDecoder.decodeObject(forKey: PropertyKey.sentiment_1) as? String else {
            os_log("Unable to decode the journal sentiment for a JournalProperties object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let sentiment_2 = aDecoder.decodeObject(forKey: PropertyKey.sentiment_2) as? String else {
            os_log("Unable to decode the journal sentiment for a JournalProperties object.", log: OSLog.default, type: .debug)
            return nil
        }
        let sentiment = (sentiment_0, sentiment_1, sentiment_2)
        
        // Initialize object from decoded value
        self.init(journalEntry, date, time, location, sentiment)
    }
}
