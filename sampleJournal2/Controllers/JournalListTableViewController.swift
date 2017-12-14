//
//  JournalListTableViewController.swift
//  599 Prototype
//
//  This class defines the View Controller for the list of journals.
//  Persistent storage of journals occurs in this class.
//

import UIKit
import os.log

class JournalListTableViewController: UITableViewController {
    
    // Contains a list of journals
    var listOfJournals = [JournalProperties]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // If previous journals exist
        if let savedJournals = loadJournals() {
            // Return the list of journals from local storage
            listOfJournals += savedJournals
        } else {
            // For testing purposes - create a sample journal and add to list
            let sampleJournal = JournalProperties("I am pretty stressed", "21/10/2017", "10:55 PM", (51.077853, -114.130181), ("negative", "", "😔"))
            listOfJournals.append(sampleJournal!)
            saveJournals()
        }
        
        // Reload table view rows
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

    // Count number of journals in list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfJournals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath)
        
        // Configure the cell with journal data
        let currentJournal = listOfJournals[indexPath.row]
        cell.textLabel?.text = currentJournal.date + " - " + currentJournal.time + " " + currentJournal.sentiment.2
        cell.textLabel?.textColor = UIColor.white
        return cell
    }

    // MARK: - Action
    
    // When returning from another view controller
    @IBAction func unwindToJournalList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewJournalViewController {
            // New journal created
            
            // Compute newIndexPath for new journal
            let newIndexPath = IndexPath(row: listOfJournals.count, section: 0)
            
            // Create new journal and add to array
            let journal = sourceViewController.newJournal
            listOfJournals.append(journal!)
            
            // Insert to table
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        }
        else if let sourceViewController = sender.source as? JournalDetailsViewController {
            // This is a very hacky fix to ensure that the journal is only deleted if it is
            // flagged for deletion
            if (!sourceViewController.deleteJournal){
                return
            }
            
            // Journal to be deleted
            let journal = sourceViewController.selectedJournal
            
            // Find the journal in the array and delete the journal at the index
            listOfJournals.remove(at: listOfJournals.index(of: journal!)!)
        }
        
        // Save array of journals
        //    after adding a new journal entry from NewJournalViewController
        //    or if deleting an existing journal entry from JournalDetailsViewController
        saveJournals()
        
        // Reload table just in case
        tableView.reloadData()
    }
    
    // MARK: - Persistent Storage
    
    // Save Journals to local storage
    private func saveJournals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(listOfJournals, toFile: JournalProperties.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Journals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save journals...", log: OSLog.default, type: .error)
        }
    }
    
    // Load Journals from local storage
    private func loadJournals() -> [JournalProperties]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: JournalProperties.ArchiveURL.path) as? [JournalProperties]
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
            
            guard let selectedJournalCell = sender as? UITableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "nil")")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedJournalCell) else {
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
