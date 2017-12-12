//
//  EntryPointViewController.swift
//  599 Prototype
//
//  Created by Raza Qazi on 2017-11-18.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import UIKit
import ToneAnalyzerV3

class EntryPointViewController: UIViewController {
    @IBOutlet weak var newJournalEntryButton: UIButton!
    @IBOutlet weak var listOfJournalsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newJournalEntryButton.layer.cornerRadius = 10
        listOfJournalsButton.layer.cornerRadius = 10
        
        var text = "I was asked to sign a third party contract a week out from stay. If it wasn't an 8 person group that took a lot of wrangling I would have cancelled the booking straight away. Bathrooms - there are no stand alone bathrooms. Please consider this - you have to clear out the main bedroom to use that bathroom. Other option is you walk through a different bedroom to get to its en-suite. Signs all over the apartment - there are signs everywhere - some helpful - some telling you rules. Perhaps some people like this but It negatively affected our enjoyment of the accommodation. Stairs - lots of them - some had slightly bending wood which caused a minor injury."
        text.verbs
//        print(text.verbs)
//        print(text.dominantLanguage)
//        print(text.pronouns)
        print(text.language())
        
//        var username = "7ed26589-b179-4365-b91f-836a6b9af90c"
//        var password = "utIZLIYCNQwD"
//        let version = "2017-07-06" // use today's date for the most recent version
//        let toneAnalyzer = ToneAnalyzer(username: username, password: password, version: version)
//        
//        var text = "I was asked to sign a third party contract a week out from stay. If it wasn't an 8 person group that took a lot of wrangling I would have cancelled the booking straight away. Bathrooms - there are no stand alone bathrooms. Please consider this - you have to clear out the main bedroom to use that bathroom. Other option is you walk through a different bedroom to get to its en-suite. Signs all over the apartment - there are signs everywhere - some helpful - some telling you rules. Perhaps some people like this but It negatively affected our enjoyment of the accommodation. Stairs - lots of them - some had slightly bending wood which caused a minor injury."
//        var failure = { (error: Error) in print(error) }
//        //        let tones = ["emotion", "this-tone-is-invalid"]
//        toneAnalyzer.getTone(ofText: text, failure: failure) { tones in
//            for i in tones.documentTone{
//                print(i.categoryID)
//                print(i.name)
//                for t in i.tones{
//                    print(t)
//                }
//              
//            }
//        }
      
      
     
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
