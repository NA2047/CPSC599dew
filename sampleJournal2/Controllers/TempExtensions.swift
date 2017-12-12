//
//  TempExtensions.swift
//  599 Prototype
//
//  Colours for various sentiments are defined in this class.
//  These colours are used to colour text in JournalDetailsViewController.
//
//  TODO - ANDREW: why is this class called TempExtensions? Why 'temp'?

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
