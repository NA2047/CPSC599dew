
import Foundation
import UIKit

extension UIViewController{
    
    func colorForEmotionBackGround(text: String, emotionToToneDictionary:[String:String]) -> NSMutableAttributedString{
        var highlightedText = NSMutableAttributedString(string: text)
        let sentence = text.split(separator: " ")
        for word in sentence {
            let range = (text as NSString).range(of: String(word))
           checkAndColour(wordToColour: String(word),range:range, NSMutable: &highlightedText,emotionToToneDictionary: emotionToToneDictionary,forAndBack:.backgroundColor)
          

        }
         return highlightedText
    }
    
    
    func colorForEmotionForegroundAndBackground(text: String, emotionToToneDictionary:[String:String]) -> NSMutableAttributedString{
        var attribute = NSMutableAttributedString(string: text)
        let sentence = text.split(separator: " ")
        for word in sentence {
            let range = (text as NSString).range(of: String(word))
            checkAndColour(wordToColour: String(word),range:range, NSMutable: &attribute,emotionToToneDictionary: emotionToToneDictionary,forAndBack:.foregroundColor)
        }
        return attribute
        
        
    }
    
    
    /**
     This function gets the UI color assosiated to the Tone type
     
     - parameter text: string to be coloured
     - parameter emotionToToneDictionary: this dictionary should be a mapping from emotion to tone eg. "happy : joy"
     - returns: A new optional Dictionary of type [String:[String]]?
     */
    func colorForEmotionForeground(text: NSAttributedString, emotionToToneDictionary:[String:String] )->NSMutableAttributedString {
        var attribute = text.mutableCopy() as! NSMutableAttributedString
//        var attribute = NSMutableAttributedString(string: text.string)
        let sentence = text.string.split(separator: " ")
        var range = (attribute.string as NSString).range(of:String(sentence[0]))
        var range1 = NSRange(location: range.location + range.length, length: attribute.length - (range.location + range.length))
        var intermRange = attribute.string
        for word in sentence {
            print("\(word)")
            
            range = (intermRange as NSString).range(of:String(word))
//            print("range \(range.upperBound)")
//            print("range \(range.length)")
//            print("range \(range)")
         
            
//             range1 = NSRange(location: range.location + range.length, length: attribute.length - (range.location + range.length))
            var distance  = (attribute.string as NSString).length - (intermRange as NSString).length
            range1 = NSMakeRange(range.location + range.length, (attribute.string as NSString).length - (range.length))
//            print("range1 \(range1.upperBound)")
//            print("range1 \(range1.lowerBound)")
//            print("range1 \(range1)")
           
//            print(" distance \(distance)")
//            print(range1)
            
            intermRange = ( attribute.string as NSString).substring(from: range.location + range.length+distance)
            print(intermRange)
             range = NSMakeRange(range.location + distance, range.length )
            print(range)
            checkAndColour(wordToColour: word.trimmingCharacters(in: .whitespacesAndNewlines),range:range, NSMutable: &attribute,emotionToToneDictionary: emotionToToneDictionary,forAndBack:.foregroundColor)
//            range = NSMakeRange(range1.location + distance, attribute.length + distance)
            
        }
//        print(attribute)
        return attribute
    }



fileprivate func checkAndColour(wordToColour: String,
                                range: NSRange,
                                NSMutable:inout NSMutableAttributedString,
                                emotionToToneDictionary :[String:String],
                                forAndBack: NSAttributedStringKey){
    
    var tone = emotionToToneDictionary[String(wordToColour.lowercased().trimmingCharacters(in: .punctuationCharacters))]
    tone = tone?.trimmingCharacters(in: .whitespacesAndNewlines)
   let word = wordToColour.lowercased().trimmingCharacters(in: .punctuationCharacters)
   NSMutable.addAttribute(forAndBack,value:tone?.UIColorEmotion ?? word.UIColorEmotion  ,range: range)
//    }
}
    
     func add (left: NSMutableAttributedString, right: NSMutableAttributedString) -> NSMutableAttributedString
    {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }

}


