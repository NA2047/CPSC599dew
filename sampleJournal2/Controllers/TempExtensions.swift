//
//  TempExtensions.swift
//  599 Prototype
//
//  Created by Andrew on 2017-12-05.
//  Copyright © 2017 Raza Qazi. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    var UIColorEmotion:UIColor? {
        get{
            switch self{
            case "anger":
                return UIColor(red: 237/255, green: 101/255, blue: 128/255, alpha: 1.0)
            case "disgust":
                return UIColor(red: 187/255, green: 229/255, blue: 107/255, alpha: 1.0)
            case "joy":
                return UIColor(red: 245/255, green: 211/255, blue: 83/255, alpha: 1.0)
            case "surprise":
                return UIColor(red: 240/255, green: 136/255, blue: 100/255, alpha: 1.0)
            case "sadness":
                return UIColor(red: 122/255, green: 211/255, blue: 251/255, alpha: 1.0)
            case "fear":
                return UIColor(red: 165/255, green: 139/255, blue: 212/255, alpha: 1.0)
            default:
                return nil
            }
        }
    }
}
