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
    var emoji: String = ""
    let positive: String = "🙂"
    let negative: String = "🙁"
    
    var sentiment: (String, String) {
        get{
            let result = performJournalAnalysis(journalEntry)
            if (result.0 == "positive") {
                emoji = positive
            }
            else if (result.0 == "negative") {
                emoji = negative
            }
            return(result)
        }
    }
    
    init(_ journal:String, _ date:String, _ time:String) {
        self.journalEntry = journal
        self.date = date
        self.time = time
    }
    
    private func performJournalAnalysis(_ text: String) -> (String, String)  {
        let classificationService = ClassificationService()
        let result = classificationService.predictSentiment(from: text)
        let result2 = result.0.rawValue
        return (result2,String(result.1))
//        print(sentiment)
        
//        let percent =
        
        
    }
}
