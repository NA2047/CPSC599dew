//
//  LoadCSV.swift
//  599 Prototype
//
//  Created by Andrew on 2017-12-11.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import Foundation


struct LoadCSV{
    static let emotions = loadEmotions()
    
    static private func loadEmotions() -> [String:String] {
         let contentsCSV: Dictionary = Dictionary<String,String>()
        do{
            return try contentsCSV.csvOfTwoColoumToDictioanry(fileName: "emotions", typeOfFile: ".csv")
        }
        catch{
            print(error)
        }
        return contentsCSV
    } 
}
