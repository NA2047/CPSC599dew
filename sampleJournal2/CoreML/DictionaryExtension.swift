//
//  DictionaryExtension.swift
//  599 Prototype
//
//  TODO - ANDREW: give a description of what this class does
//  TODO - ANDREW: provide more documentation for your code below, fix typos
//

import Foundation
extension Dictionary{
    // TODO - ANDREW: function name contains typos
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

    

