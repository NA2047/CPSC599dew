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
//        guard let filepath = Bundle.main.path(forResource: "emotions", ofType: ".csv")
//            else {
//                return
//        }
//        var dict = [String:String]()
//        let url = URL(fileURLWithPath: filepath)
//        do {
//            let file = try String(contentsOf: url)
//            let rows = file.components(separatedBy: .newlines)
//
//            for row in rows {
//                let fields = row.split(separator: ",")
//                dict[fields[0]] = dict[fields[1]]
//                let new = fields.map{(row)->[String:String] in
//                    let dict: [String:String] = [row.0:row.1]
//                    return dict
//                }
//
//                print(fields[1])
//            }
//            print(dict)
//        } catch {
//            print(error)
//        }
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
