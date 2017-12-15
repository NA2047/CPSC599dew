//
//  EntryPointViewController.swift
//  599 Prototype
//
//  This View Controller simply contains the two buttons
//  that allow for adding a new journal entry or viewing
//  the list of journal entries.
//

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
    }

    @IBAction func dooit(_ sender: UIButton) {
         var texts = "I was asked to sign a third party contract a week out from stay. If it wasn't an 8 person group that took a lot of wrangling I would have cancelled the booking straight away. Bathrooms - there are no stand alone bathrooms. Please consider this - you have to clear out the main bedroom to use that bathroom. Other option is you walk through a different bedroom to get to its en-suite. Signs all over the apartment - there are signs everywhere - some helpful - some telling you rules. Perhaps some people like this but It negatively affected our enjoyment of the accommodation. Stairs - lots of them - some had slightly bending wood which caused a minor injury."
//        t.getEmotionalTones(textToBeAnalyzed: texts)
//        if let d = t.emotions {
//            print(d)
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
