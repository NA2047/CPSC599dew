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

import UIKit
import MapKit

class JournalDetailsViewController: UIViewController, UITextViewDelegate {
    // Connect UI elements from Storyboard
    @IBOutlet weak var deleteJournalEntryButton: UIBarButtonItem!
    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationMapView: MKMapView!
    
    // Contains selected journal from list view
    var selectedJournal: JournalProperties?
    
    //delete journal flag -> true == delete, false == do not delete
    var deleteJournal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegate to self to detect
        journalTextView.delegate = self
        
        // rounded text view box
        journalTextView.layer.cornerRadius = 10
        
        // reset deleteJournal flag to false
        deleteJournal = false
        
        // Populate UI with journal details
        self.title = selectedJournal?.date
        journalTextView.text = selectedJournal?.journalEntry
        emotionLabel.text = (selectedJournal?.sentiment.0)! + " " + (selectedJournal?.sentiment.2)!
        
        // Set locationview with journal location data
        let location = CLLocation(latitude: (selectedJournal?.location?.latitude)!, longitude: (selectedJournal?.location?.longitude)!)
        centerMapOnLocation(location: location)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {


            journalTextView.attributedText = getColorForEmotion(text: journalTextView.text!, emotionToToneDictionary: LoadCSV.emotions)

  

    }
    
    func centerMapOnLocation(location: CLLocation) {
        //Gets long and lat from stored location
        let latitude: CLLocationDegrees = location.coordinate.latitude
        let longitude: CLLocationDegrees = location.coordinate.longitude
        
        //Sets coordinates for map
        let coordinateRegion = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        //trouble shooting code
        //print(latitude, longitude)
        
        //Controls how the map appears, how zoomed in it is
        let lonDelta: CLLocationDegrees = 0.05
        let lanDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: lonDelta)
        
        //sets centre of map and how zoomed in it will be
        let region = MKCoordinateRegion(center: coordinateRegion, span: span)

        //creates view
        locationMapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
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
