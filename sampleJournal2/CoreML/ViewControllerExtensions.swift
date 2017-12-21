
import Foundation
import UIKit

extension UIViewController{
    
    /**
     This function gets the UI color assosiated to the Tone type and highlights the text with the respective emotional colour and changes the colour text to black to create a better contract, this function will also handle duplicates and colour them accordingly
     
     - parameter NSAttributedString: string to be coloured
     - parameter emotionToToneDictionary: this dictionary should be a mapping from emotion to tone eg. "happy : joy"
     - returns: A new optional Dictionary of type [String:[String]]?
     */
    func colorForEmotionBackGround(text: NSAttributedString, emotionToToneDictionary:[String:String] )->NSMutableAttributedString {
        // this line will save all current text formating and add the text highlighting and contrast
        // instead of current funtionallity which erase it
        //        var attributesToBeReturned = text.mutableCopy() as! NSMutableAttributedString
        var attributesToBeReturned = NSMutableAttributedString(string: text.string)
        let sentences = text.string.split(separator: " ")
        var searchRange = (attributesToBeReturned.string as NSString).range(of:String(sentences[0]))
        var serachString = attributesToBeReturned.string
        for word in sentences {
            
            searchRange = (serachString as NSString).range(of:String(word))
            
            let distance  = (attributesToBeReturned.string as NSString).length - (serachString as NSString).length
            let offSetDistance = searchRange.location + searchRange.length + distance
            
            serachString = ( attributesToBeReturned.string as NSString).substring(from: offSetDistance)
            searchRange = NSMakeRange(searchRange.location + distance, searchRange.length )
            
            checkAndColour(wordToColour: word.trimmingCharacters(in: .whitespacesAndNewlines),range:searchRange, NSMutable: &attributesToBeReturned,emotionToToneDictionary: emotionToToneDictionary,forAndBack:.backgroundColor,flag: true)
        }
        
        return attributesToBeReturned
    }
    
    
    
    
    /**
     This function gets the UI color assosiated to the Tone type and highlights the text with the respective emotional colour and changes the colour text to black to create a better contract, this function will also handle duplicates and colour them accordingly
     
     - parameter NSAttributedString: string to be coloured
     - parameter emotionToToneDictionary: this dictionary should be a mapping from emotion to tone eg. "happy : joy"
     - returns: A new optional Dictionary of type [String:[String]]?
     */
    func colorForEmotionForeground(text: NSAttributedString, emotionToToneDictionary:[String:String] )->NSMutableAttributedString {
        // this line will save all current text formating and add the text highlighting and contrast
        // instead of current funtionallity which erase it
        // var attributesToBeReturned = text.mutableCopy() as! NSMutableAttributedString
        var attributesToBeReturned = NSMutableAttributedString(string: text.string)
        let sentences = text.string.split(separator: " ")
        var searchRange = (attributesToBeReturned.string as NSString).range(of:String(sentences[0]))
        var serachString = attributesToBeReturned.string
        for word in sentences {
            
            searchRange = (serachString as NSString).range(of:String(word))
            
            let distance  = (attributesToBeReturned.string as NSString).length - (serachString as NSString).length
            let offSetDistance = searchRange.location + searchRange.length + distance
            
            serachString = ( attributesToBeReturned.string as NSString).substring(from: offSetDistance)
            searchRange = NSMakeRange(searchRange.location + distance, searchRange.length )
            
            checkAndColour(wordToColour: word.trimmingCharacters(in: .whitespacesAndNewlines),range:searchRange, NSMutable: &attributesToBeReturned,emotionToToneDictionary: emotionToToneDictionary,forAndBack:.foregroundColor,flag:false)
        }
        
        return attributesToBeReturned
    }
    
    
    
    fileprivate func checkAndColour(wordToColour: String,
                                    range: NSRange,
                                    NSMutable:inout NSMutableAttributedString,
                                    emotionToToneDictionary :[String:String],
                                    forAndBack: NSAttributedStringKey,
                                    flag:Bool){
        var tone = emotionToToneDictionary[String(wordToColour.lowercased().trimmingCharacters(in: .punctuationCharacters))]
        tone = tone?.trimmingCharacters(in: .whitespacesAndNewlines)
        let word = wordToColour.lowercased().trimmingCharacters(in: .punctuationCharacters)
        if flag {
            NSMutable.addAttribute(forAndBack,value:tone?.UIColorEmotion ?? UIColor.clear ,range: range)
            NSMutable.addAttribute(.foregroundColor,value:tone?.UIColorEmotionText ?? word.UIColorEmotionText ,range: range)
        }else{
            
            NSMutable.addAttribute(forAndBack,value:tone?.UIColorEmotion ?? word.UIColorEmotion  ,range: range)
            
            
        }
        //
    }
    
}


