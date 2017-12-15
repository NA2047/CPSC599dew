//
//  EntryPointViewController.swift
//  599 Prototype
//
//  This View Controller simply contains the two buttons
//  that allow for adding a new journal entry or viewing
//  the list of journal entries.
//
//  TODO - RAZA: remove unnecessary code, if any

import UIKit
import ToneAnalyzerV3

class EntryPointViewController: UIViewController {
    @IBOutlet weak var newJournalEntryButton: UIButton!
    @IBOutlet weak var listOfJournalsButton: UIButton!
    var t:Tones = Tones()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newJournalEntryButton.layer.cornerRadius = 10
        listOfJournalsButton.layer.cornerRadius = 10
        
        var text = "I was asked to sign a third party contract a week out from stay. If it wasn't an 8 person group that took a lot of wrangling I would have cancelled the booking straight away. Bathrooms - there are no stand alone bathrooms. Please consider this - you have to clear out the main bedroom to use that bathroom. Other option is you walk through a different bedroom to get to its en-suite. Signs all over the apartment - there are signs everywhere - some helpful - some telling you rules. Perhaps some people like this but It negatively affected our enjoyment of the accommodation. Stairs - lots of them - some had slightly bending wood which caused a minor injury."
//        text.verbs
//        print(text.verbs)
//        print(text.dominantLanguage)
//        print(text.pronouns)
//        print(text.language())
//        print(text.sentences)
//        text.sentences
//        text.generticTagger(tags:[.verb,.noun])
        
//        var username = "7ed26589-b179-4365-b91f-836a6b9af90c"
//        var password = "utIZLIYCNQwD"
//        let version = "2017-07-06" // use today's date for the most recent version
//        let toneAnalyzer = ToneAnalyzer(username: username, password: password, version: version)
//        
        
        
//        t = nil
      
      
//        print(t.social)
//        t.social = nil
        
//        t.getEmotionalTones(textToBeAnalyzed: texts)
//////
//        t.getWritingTones(textToBeAnalyzed: texts)
//        print(t.emotions2)
        
//        print(f)
//
//        print(t)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
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
        //        var test: Dictionary = Dictionary<String,String>()
        //        do{
        //            let t = try test.csvOfTwoColoumToDictioanry(fileName: "emotions", typeOfFile: ".csv")
        //            print(t)
        //
        //        }
        //        catch{
        //            print(error)
        
        //        }
      
       
        //        t.getTones(textToBeAnalyzed: texts)
        //        var f = [String:Double]()
        //        do {
        //            var loopBreaker = Tones.construct()
        //            loopBreaker()
        //             withExtendedLifetime(loopBreaker) {}
        //        }
        typealias CompletionHandler = (_ success:Bool) -> Void
        //        print(t.emotions)
        //        print(t.t)
        
        
        
    }
    
    @IBAction func dooit(_ sender: UIButton) {
         var texts = "I was asked to sign a third party contract a week out from stay. If it wasn't an 8 person group that took a lot of wrangling I would have cancelled the booking straight away. Bathrooms - there are no stand alone bathrooms. Please consider this - you have to clear out the main bedroom to use that bathroom. Other option is you walk through a different bedroom to get to its en-suite. Signs all over the apartment - there are signs everywhere - some helpful - some telling you rules. Perhaps some people like this but It negatively affected our enjoyment of the accommodation. Stairs - lots of them - some had slightly bending wood which caused a minor injury."
        t.getEmotionalTones(textToBeAnalyzed: texts)
        if let d = t.emotions {
            print(d)
        }
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
