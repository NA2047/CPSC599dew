//
//  ViewControllerExtentions.swift
//  599 Prototype
//
//  Created by Andrew on 2017-11-30.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func getColorForEmotion(text: String,wordToColor: String)->String {
        let range = (text as NSString).range(of: wordToColor)
        
        let attribute = NSMutableAttributedString.init(string: text)
         attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
        return attribute.string
        
        
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
}

}
