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
