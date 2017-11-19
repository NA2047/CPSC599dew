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
    var sentiment: (String, String) = ("","")
    
    init(_ journal:String, _ date:String, _ time:String) {
        self.journalEntry = journal
        self.date = date
        self.time = time
        // self.sentiment = performJournalAnalysis(journal)
    }
    
    func performJournalAnalysis(_ text: String) {
        // something something
        // return performSentimentAnalysis(text)
    }
}
