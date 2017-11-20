//
//  JournalListTableViewController.swift
//  599 Prototype
//
//  Created by Raza Qazi on 2017-11-18.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import UIKit

class JournalListTableViewController: UITableViewController {
    
    var sampleJournal = JournalProperties("I am pretty stressed", "21/10/2017", "10:55 PM")
    var listOfJournals = [JournalProperties]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // For testing purposes
        listOfJournals.append(sampleJournal)
        
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfJournals.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = listOfJournals[indexPath.row].date
        cell.textLabel?.textColor = UIColor.white
        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // MARK: - Action
    @IBAction func unwindToJournalList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewJournalViewController {
            let journal = sourceViewController.newJournal
            listOfJournals.append(journal!)
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
       
        // Tap + icon from Journal Entries View
        case "CreateJournalEntryFromList":
            break
        
        // Tapping on a journal in the list
        case "ViewSingleJournal":
            guard let journalDetailsViewController = segue.destination as? JournalDetailsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? UITableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "nil")")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedJournal = listOfJournals[indexPath.row]
            journalDetailsViewController.selectedJournal = selectedJournal
            
            break
            
        // Tapping "home" from Journal Entries
        case "ReturnHomeFromList":
            break
        
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "nil")")
        }
    }
    

}
