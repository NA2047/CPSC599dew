//
//  DictionaryExtension.swift
//  599 Prototype
//
//  Created by Andrew on 2017-12-02.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import Foundation
extension Dictionary{
    
    func csvToDictioanry()  {
        guard let filepath = Bundle.main.path(forResource: "emotions", ofType: ".csv")
            else {
                return
        }
        
        let url = URL(fileURLWithPath: filepath)
        do {
            let file = try String(contentsOf: url)
            let rows = file.components(separatedBy: .newlines)
            for row in rows {
                let fields = row.replacingOccurrences(of: "\"", with: "").components(separatedBy: ",")
                print(fields)
            }
        } catch {
            print(error)
        }
//        do {
//            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
//
//            return contents
//        } catch {
//            print("File Read Error for file \(filepath)")
//            return nil
//        }
    }
    }
    

