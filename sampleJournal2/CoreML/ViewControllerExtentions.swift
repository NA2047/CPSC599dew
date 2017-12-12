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
    
    func getColorForEmotion(text: String,wordToColor: String, dict:[String:String] )->NSMutableAttributedString {
        let attribute = NSMutableAttributedString(string: text)
        let flat2 = text.split(separator: " ")
        for word in flat2 {
            if let val = dict[String(word)] {
                if let color = val.UIColorEmotion{
                    let range = (text as NSString).range(of: String(word))
                    attribute.addAttribute(NSAttributedStringKey.foregroundColor, value:color , range: range)
                }
                else{
                  print("\(word) cannot be assosiated to an emotion")
                }
              
            }
            else {
                print("key not found for \(word)")
            }
        }
        return attribute
//        txtfield1 = UITextField.init(frame:CGRect(x:10 , y:20 ,width:100 , height:100))
//        txtfield1.attributedText = attribute
        
//        var myMutableString = NSMutableAttributedString()
//
//        myMutableString = NSMutableAttributedString(string: "Your full label textString")
//
//        myMutableString.setAttributes([NSFontAttributeName : UIFont(name: "HelveticaNeue-Light", size: CGFloat(17.0))!
//            , NSForegroundColorAttributeName : UIColor(red: 232 / 255.0, green: 117 / 255.0, blue: 40 / 255.0, alpha: 1.0)], range: NSRange(location:12,length:8)) // What ever range you want to give
//
//        yourLabel.attributedText = myMutableString
//}
//    func getColorForEmotions(text: String,wordStoColor: [String:String], textView : UITextView)->NSMutableAttributedString{
////        var flat1 = wordStoColor.flatMap { (key,value) -> String? in
////                    return key
////                }
//        print(wordStoColor)
//        var finalSentence = NSMutableAttributedString()
//        let flat2 = text.split(separator: " ")
//        for word in flat2 {
//            if let val = wordStoColor[String(word)] {
//                finalSentence.append(getColorForEmotion(text: String(word), wordToColor: val))
//            }else {
//                print("key not found for \(word)")
//            }
//        }
//        for wor in finalSentence{
//
//        }
//        print(finalSentence)
//        return finalSentence.joined(separator: " ")
////        myMutableString = NSMutableAttributedString()
//////        myMutableString = NSMutableAttributedString(string: text as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!])
////        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location:2,length:2))
////        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: NSRange(location:5,length:5))
////        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location:11,length:4))
////        lbl_Second.attributedText = myMutableString
////
//    }
    }
}
