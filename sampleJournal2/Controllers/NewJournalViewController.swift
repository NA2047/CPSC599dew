//
//  NewJournalViewController.swift
//  sampleJournal2
//
//  Created by Raza Qazi on 2017-11-15.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//
import UIKit
import CoreLocation

class NewJournalViewController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    

    var locationManager = CLLocationManager()

    

    var oldBottomConstraint: CGFloat = 0.0
    
    @IBOutlet weak var saveJournalEntryButton: UIBarButtonItem!

    var startEditing: Bool = false
    var newJournal: JournalProperties?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalTextView.delegate = self
        journalTextView.layer.cornerRadius = 10
        saveJournalEntryButton.isEnabled = false
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        print((locationManager.location?.coordinate.latitude ?? 0))
        print((locationManager.location?.coordinate.longitude ?? 0))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name:NSNotification.Name.UIKeyboardWillShow, object: nil);


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        saveJournalEntryButton.isEnabled = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !self.startEditing {
            textView.text = ""
            textView.textColor = UIColor.white
            self.startEditing = true
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.inputAccessoryView = toolbar
        return true
    }
    
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
            
            if let latitude = locationManager.location?.coordinate.latitude,let longitude = locationManager.location?.coordinate.longitude {
                currentLocation = (latitude,longitude)
                print("here")
                print(currentLocation)
                print(longitude)
                
            }
//            let longitude = locationManager.location?.coordinate.longitude
//            currentLocation = ((locationManager.location?.coordinate.latitude ?? 0),(locationManager.location?.coordinate.longitude ?? 0))
           
            

            
//            currentLocation = (locationManager.)
            
            var currentSentiment: (String, String, String) {
                get{
                    let result = performJournalAnalysis(enteredJournal!)
                    return(result)
                }
            }
            
            
            // New journal object
            let newJournal = JournalProperties(enteredJournal!, currentDate, currentTime, currentLocation, currentSentiment)
            self.newJournal = newJournal
            print(newJournal?.sentiment)
            
            print(newJournal?.location!)

            print(newJournal?.journalEntry)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        saveJournalEntry()
    }
    
    @IBAction func textfieldDoneButtonTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        bottomConstraint.constant = self.oldBottomConstraint
    }
    
    
    private func performJournalAnalysis(_ text: String) -> (String, String, String)  {
        let classificationService = ClassificationService()
        let result = classificationService.predictSentiment(from: text)
        let result2 = result.0.rawValue
        return (result2, String(result.1), result.0.emoji)
        //        print(sentiment)
        
        //        let percent =
        
        
    }

   
    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])->CLLocation {
        let userLocation: CLLocation = locations[0]
        
//        let latitude = userLocation.coordinate.latitude
//        let longitude = userLocation.coordinate.longitude
//
//        print(locations)
        
        
        return userLocation
    }
    
    

    // From stack overflow - find keyboard height
    @objc func keyboardShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        oldBottomConstraint = bottomConstraint.constant
        bottomConstraint.constant = keyboardFrame.height + 10.0
    }

}
