
import Foundation

/**
 This function struct is used to store and hold a single loaded value of emotions CSV
 
 */
struct LoadCSV{
    static let emotions = loadEmotions()
    
    static fileprivate func loadEmotions() -> [String:String] {
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
