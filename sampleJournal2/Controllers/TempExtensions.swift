//
//  TempExtensions.swift
//  599 Prototype
//
//  Created by Andrew on 2017-12-05.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    var UIColorEmotion:UIColor? {
        get{
            switch self{
            case "anger":
                return UIColor.red
            case "disgust":
                return UIColor.brown
            case "joy":
                return UIColor.green
            case "surprise":
                return UIColor.purple
            case "sadness":
                return UIColor.magenta
            case "fear":
                return UIColor.orange
            default:
                return nil
            }
        }
    }
}

extension Dictionary{
    func csvOfTwoColoumToDictioanry(fileName fileToOpen: String, typeOfFile fileType: String ) throws -> [String:String]  {
        guard let filepath = Bundle.main.path(forResource: fileToOpen, ofType: fileType)
            else {
                throw "File not found"
        }
        //        var dict = [String: String]()
        var dict = self as! [String:String]
        let url = URL(fileURLWithPath: filepath)
        do {
            let file = try String(contentsOf: url)
            let rows = file.components(separatedBy: .newlines)
            for row in rows {
                if (String(row) != ""){
                    let fields = row.split(separator: ",")
                    dict[String(fields[0])] = String(fields[1])
                }
            }
            
        } catch {
            print(error)
        }
        return dict
    }
}




