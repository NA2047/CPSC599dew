//
//  ViewControllerExtentions.swift
//  599 Prototype
//
//  TODO - ANDREW: give a description of what this class does
//  TODO - ANDREW: fix the typo in the name of this class
//  TODO - ANDREW: get rid of unused code, fix typos
//

import Foundation
import UIKit

extension UIViewController{
    
//    func highlightTextWithResponse(text: String, emotionToToneDictionary:[String:String]) {
//        let highlightedText = NSMutableAttributedString(attributedString: text)
//        
//        if let positiveElements = response["positive"].array {
//            for element in positiveElements {
//                guard let elementText = element["original_text"].string else {
//                    continue
//                }
//                
//                highlightedText.addAttribute(NSForegroundColorAttributeName,
//                                             value: UIColor.white,
//                                             range: (text as NSString).range(of: elementText)
//                )
//                
//                highlightedText.addAttribute(NSBackgroundColorAttributeName,
//                                             value: AppColor.positive,
//                                             range: (text as NSString).range(of: elementText)
//                )
//            }
//        }
//        
//        if let negativeElements = response["negative"].array {
//            for element in negativeElements {
//                guard let elementText = element["original_text"].string else {
//                    continue
//                }
//                
//                highlightedText.addAttribute(NSForegroundColorAttributeName,
//                                             value: UIColor.white,
//                                             range: (text as NSString).range(of: elementText)
//                )
//                
//                highlightedText.addAttribute(NSBackgroundColorAttributeName,
//                                             value: AppColor.negative,
//                                             range: (text as NSString).range(of: elementText)
//                )
//            }
//        }
//        
//        self.attributedText = highlightedText
//    }
//    
    
    /**
     This function gets the UI color assosiated to the Tone type
     
     - parameter text: string to be coloured
     - parameter emotionToToneDictionary: this dictionary should be a mapping from emotion to tone eg. "happy : joy"
     - returns: A new optional Dictionary of type [String:[String]]?
     */
    func getColorForEmotion(text: String, emotionToToneDictionary:[String:String] )->NSMutableAttributedString {
        let attribute = NSMutableAttributedString(string: text)
        let flat2 = text.split(separator: " ")
        for word in flat2 {
            let range = (text as NSString).range(of: String(word))
            if var val = emotionToToneDictionary[String(word.lowercased().trimmingCharacters(in: .punctuationCharacters))] {
                val = val.trimmingCharacters(in: .whitespacesAndNewlines)
                if let color = val.UIColorEmotion{
                    attribute.addAttribute(NSAttributedStringKey.foregroundColor, value:color , range: range)
                }
                else{
                  print("\(word) cannot be assosiated to an emotion")
                }
            }
            else {
                print("key not found for \(word)")
                attribute.addAttribute(NSAttributedStringKey.foregroundColor, value:UIColor.white , range: range)
            }
        }
        return attribute
    }
}

extension UIColor {
    func hexString() -> String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
}
