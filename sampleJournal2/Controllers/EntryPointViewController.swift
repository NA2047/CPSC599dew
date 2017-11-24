//
//  EntryPointViewController.swift
//  599 Prototype
//
//  Created by Raza Qazi on 2017-11-18.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import UIKit

class EntryPointViewController: UIViewController {
    @IBOutlet weak var newJournalEntryButton: UIButton!
    @IBOutlet weak var listOfJournalsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newJournalEntryButton.layer.cornerRadius = 10
        listOfJournalsButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
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
