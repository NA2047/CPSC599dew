//
//  NewJournalViewController.swift
//  sampleJournal2
//
//  Created by Raza Qazi on 2017-11-15.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var ViewTextField: UITextView!
    
    var startEditing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewTextField.delegate = self;
    }
    
    class JournalProperties {
        var journalEntry: String = ""
        var date: String = ""
        var time: String = ""
        
        init(_ journal:String, _ date:String, _ time:String) {
            self.journalEntry = journal
            self.date = date
            self.time = time
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if !self.startEditing {
            textView.text = ""
            textView.textColor = UIColor.black
            self.startEditing = true
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.inputAccessoryView = toolbar
        return true
    }
    
    @IBAction func saveJournalEntry(_ sender: UIButton) {
        if self.ViewTextField.text == "" || self.ViewTextField.text == "Write here..." {
            // Did not add anything new, yet.
            print("No change in text field")
        } else {
            // Process new journal entry
            
            // Determine Date
            let date = Date()
            
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "MM/dd/yyyy"
            let currentDate = dateFormat.string(from: date)
            
            let timeFormat = DateFormatter()
            timeFormat.timeStyle = .short
            let currentTime = timeFormat.string(from: date)
            
            // Store text entered into journal field
            let enteredJournal = ViewTextField.text
            
            // New journal object
            let newJournal = JournalProperties(enteredJournal!, currentDate, currentTime)
            
            print(newJournal.journalEntry)
        }
    }
    
    @IBAction func textfieldDoneButtonTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
}

