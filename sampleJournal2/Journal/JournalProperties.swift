//
//  JournalProperties.swift
//  599 Prototype
//
//  Created by Raza Qazi on 2017-11-18.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import Foundation

class JournalProperties {
    var journalEntry: String = ""
    var date: String = ""
    var time: String = ""
    var location: (longitude: Double, latitude: Double)? = nil
    var sentiment: (String, String, String) = ("", "", "")
    
    init(_ journal:String, _ date: String, _ time: String, _ location: (Double, Double), _ sentiment: (String, String, String)) {
        self.journalEntry = journal
        self.date = date
        self.time = time
        self.location = location
        self.sentiment = sentiment
    }
}
