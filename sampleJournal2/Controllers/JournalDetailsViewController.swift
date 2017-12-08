//
//  JournalDetailsViewController.swift
//  599 Prototype
//
//  Created by Raza Qazi on 2017-11-18.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import UIKit
import MapKit

class JournalDetailsViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var deleteJournalEntryButton: UIBarButtonItem!
    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationMapView: MKMapView!
    
    
    var selectedJournal: JournalProperties?
    var deleteJournal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        journalTextView.delegate = self
        journalTextView.layer.cornerRadius = 10
        deleteJournal = false
        self.title = selectedJournal?.date
        journalTextView.text = selectedJournal?.journalEntry
        emotionLabel.text = (selectedJournal?.sentiment.0)! + " " + (selectedJournal?.sentiment.2)!

        print(selectedJournal?.journalEntry ?? "could not print journal entry")
        print(selectedJournal?.time ?? "could not print time")
        
        print( (selectedJournal?.location?.latitude)!)
        
        
        let location = CLLocation(latitude: (selectedJournal?.location?.latitude)!, longitude: (selectedJournal?.location?.longitude)!)
        
        
        // 51.077660, -114.130413
        // mac hall coordinates
        // hardcoded for now, location isn't working properly
        
//        let location = CLLocation(latitude: 51.077660, longitude: -114.130413)
        
        
        
        centerMapOnLocation(location: location)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
 
        let test: Dictionary = Dictionary<String,String>()
        do{
            let t = try test.csvOfTwoColoumToDictioanry(fileName: "emotions", typeOfFile: ".csv")
            journalTextView.attributedText = getColorForEmotion(text: journalTextView.text!, wordToColor: "poop", dict: t)
            
            journalTextView.font = UIFont(name: (journalTextView.font?.fontName)!, size: 18.0)
        }
        catch{
            print(error)
        }
        //
//
//
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let latitude: CLLocationDegrees = location.coordinate.latitude
        let longitude: CLLocationDegrees = location.coordinate.longitude
        
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
    
    @IBAction func deleteJournalEntryButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Delete Journal Entry?", message: "This action cannot be undone.", preferredStyle: UIAlertControllerStyle.alert)
        
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteJournal = true
            self.performSegue(withIdentifier: "unwindToJournalListWithSender", sender: self)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        
        alert.addAction(cancel)
        alert.addAction(delete)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    

}
