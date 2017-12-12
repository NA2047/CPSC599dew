//
//  JournalDetailsViewController.swift
//  599 Prototype
//
//  This View Controller displays the details for a journal entry,
//  such as the journal text, local, sentiment, etc.
//
//  Other information like weather and dew. survey results can be
//  displayed in this View Controller.
//
//  TODO - RAZA: provide more documentation for code if you think it's needed
//  TODO - RAZA: remove unnecessary code

import UIKit
import MapKit

class JournalDetailsViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var deleteJournalEntryButton: UIBarButtonItem!
    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationMapView: MKMapView!
    
    var selectedJournal: JournalProperties?
    var deleteJournal = false // delete journal flag -> true == delete, false == do not delete
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        journalTextView.delegate = self
        journalTextView.layer.cornerRadius = 10 // rounded text view box
        deleteJournal = false // reset deleteJournal flag to false
        self.title = selectedJournal?.date
        journalTextView.text = selectedJournal?.journalEntry
        emotionLabel.text = (selectedJournal?.sentiment.0)! + " " + (selectedJournal?.sentiment.2)!

        print(selectedJournal?.journalEntry ?? "could not print journal entry")
        print(selectedJournal?.time ?? "could not print time")
        print( (selectedJournal?.location?.latitude)!)
        
        let location = CLLocation(latitude: (selectedJournal?.location?.latitude)!, longitude: (selectedJournal?.location?.longitude)!)
        
        centerMapOnLocation(location: location)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {

            journalTextView.attributedText = getColorForEmotion(text: journalTextView.text!, dict: LoadCSV.emotions)

  
    }
    
    //  TODO - MIKE: remove any code that's unnecessary
    //  TODO - MIKE: add more documentation if you think it's warranted
    func centerMapOnLocation(location: CLLocation) {
        let latitude: CLLocationDegrees = location.coordinate.latitude
        let longitude: CLLocationDegrees = location.coordinate.longitude
        
        //  TODO - MIKE: Xcode is saying that regionRadius is never used. Can we get rid of it?
        let regionRadius: CLLocationDistance = 1000
        
        let coordinateRegion = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        print(latitude, longitude)
        
        let lonDelta: CLLocationDegrees = 0.05
        let lanDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: lonDelta)
        
        let region = MKCoordinateRegion(center: coordinateRegion, span: span)

        locationMapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        
//        myAnnotation.title = "Current location"
        locationMapView.addAnnotation(myAnnotation)
    }
    
    // Function for deleting a journal entry
    @IBAction func deleteJournalEntryButtonPressed(_ sender: UIBarButtonItem) {
        // Create new alert controller
        let alertTitle = "Delete Journal Entry?"
        let alertMessage = "This action cannot be undone."
        let alert = UIAlertController(title: alertTitle , message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        // Delete action button in alert
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteJournal = true // Set flag for journal entry to be deleted
            self.performSegue(withIdentifier: "unwindToJournalListWithSender", sender: self) // Move back to journal list
        })
        
        // Cancel action button in alert
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        
        // Add actions to the alert
        alert.addAction(cancel)
        alert.addAction(delete)
        
        // Display the alert
        self.present(alert, animated: true, completion: nil)
    }
}
