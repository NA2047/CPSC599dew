//
//  JournalDetailsViewController.swift
//  599 Prototype
//
//  Created by Raza Qazi on 2017-11-18.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import UIKit

class JournalDetailsViewController: UIViewController {
    @IBOutlet weak var deleteJournalEntryButton: UIBarButtonItem!
    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var journalTextView: UITextView!
    var selectedJournal: JournalProperties?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.title = selectedJournal?.date
        journalTextView.text = selectedJournal?.journalEntry
        emotionLabel.text = (selectedJournal?.sentiment.0)! + " " + (selectedJournal?.sentiment.2)!
        
        print(selectedJournal?.journalEntry ?? "could not print journal entry")
        print(selectedJournal?.time ?? "could not print time")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteJournalEntryButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Delete Journal Entry?", message: "This action cannot be undone.", preferredStyle: UIAlertControllerStyle.alert)
        
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.performSegue(withIdentifier: "unwindToJournalListWithSender", sender: self)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        
        alert.addAction(cancel)
        alert.addAction(delete)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
