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

class EntryPointViewController: UIViewController {
    @IBOutlet weak var newJournalEntryButton: UIButton!
    @IBOutlet weak var listOfJournalsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newJournalEntryButton.layer.cornerRadius = 10 // rounded button
        listOfJournalsButton.layer.cornerRadius = 10 // rounded button
//        var test: Dictionary = Dictionary<String,String>()
//        do{
//            let t = try test.csvOfTwoColoumToDictioanry(fileName: "emotions", typeOfFile: ".csv")
//            print(t)
//            
//        }
//        catch{
//            print(error)
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
