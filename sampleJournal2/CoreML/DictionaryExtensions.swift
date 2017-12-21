

import Foundation

extension Dictionary{
    
    /**
     This function loads in a two colum CSV and converts it to a dictionary with  the first colum  as the key and the second as the value.
     
     - parameter fileName: the name of the file to be loaded in String form without extension
     - parameter typeOfFile: file extension of the file
     - return a Ditionary of type [String:String]
     */
    func csvOfTwoColoumToDictioanry(fileName fileToOpen: String, typeOfFile fileType: String ) throws -> [String:String]  {
        guard let filepath = Bundle.main.path(forResource: fileToOpen, ofType: fileType)
            else {
                throw "File not found"
        }
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
    
    //    let mutableAttributedString = NSMutableAttributedString()
    
    
    /**
     merges two dictionaries together
     
     - parameter dict: a ditionary to be merged with the calling instance
     */
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}

//extension NSMutableAttributedString {
//    
//    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
//    {
//        let result = NSMutableAttributedString()
//        result.append(left)
//        result.append(right)
//        return result
//    }
//    
//}

