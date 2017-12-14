//
//  NewJournalViewController.swift
//  sampleJournal2
//
//  This class contains the logic for writing a new journal
//  entry and grabbing the user's location. A new JournalProperties
//  object is created once a user presses 'Save'.
//
//  Logic for linking a user's weather to a journal entry should be
//  done here.
//

import UIKit
import CoreLocation

class NewJournalViewController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveJournalEntryButton: UIBarButtonItem!

    var startEditing: Bool = false
    var newJournal: JournalProperties?
    var locationManager = CLLocationManager()
    var oldBottomConstraint: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        journalTextView.delegate = self
        journalTextView.layer.cornerRadius = 10
        
        // Disable save button until journal text view is populated
        saveJournalEntryButton.isEnabled = false
        
        // Store bottom constraint
        oldBottomConstraint = bottomConstraint.constant
        
        // Setup Location Manager to access device location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
       
        // Call 'keyboardShown' when keyboard is detected to show onscreen
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Store Journal after tapping the "Save" button
    func saveJournalEntry() {
        if self.journalTextView.text == "" || self.journalTextView.text == "Write here..." {
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
            let enteredJournal = journalTextView.text
            
            // Get current location
            // should be working but seems like its not getting here?
            var currentLocation = (0.0,0.0)
            
            if let latitude = locationManager.location?.coordinate.latitude, let longitude = locationManager.location?.coordinate.longitude {
                currentLocation = (latitude,longitude)
            }
            
            // New journal object
            let newJournal = JournalProperties(enteredJournal!, currentDate, currentTime, currentLocation, enteredJournal!.performJournalAnalysis())
            self.newJournal = newJournal
        }
    }
    
    // Detect segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        saveJournalEntry()
    }
    
    // Hide keyboard and resize textview field to height of display
    @IBAction func textfieldDoneButtonTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        bottomConstraint.constant = self.oldBottomConstraint
    }
    
    // Enable "Save" button
    func textViewDidChange(_ textView: UITextView) {
        saveJournalEntryButton.isEnabled = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // Remove preloaded text and set text color
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !self.startEditing {
            textView.text = ""
            textView.textColor = UIColor.white
            self.startEditing = true
        }
    }
    
    // Show keyboard toolbar with "Done" icon
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.inputAccessoryView = toolbar
        return true
    }
    
    // Find keyboard height
    // Source: https://stackoverflow.com/questions/25451001/getting-keyboard-size-from-userinfo-in-swift
    @objc func keyboardShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        bottomConstraint.constant = keyboardFrame.height + 10.0
    }
    
    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])->CLLocation {
        let userLocation: CLLocation = locations[0]
        return userLocation
    }
}
