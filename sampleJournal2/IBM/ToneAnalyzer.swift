//
//  ToneAnalyzer.swift
//  BackEndModels
//
//  TODO - ANDREW: give a description of what this class does
//  TODO - ANDREW: provide more documentation on what the code does
//

import Foundation
import ToneAnalyzerV3

class Tones{
    
    let ToneAnalyzes:ToneAnalyzer = ToneAnalyzer(username: "7ed26589-b179-4365-b91f-836a6b9af90c", password: "utIZLIYCNQwD", version: "2017-07-06")
    
    var flagSocail:Bool{
        
        get{
            if social != nil{
                return true
            }
            return false
        }
        
        
    }
    var flagEmotion:Bool{
        
        get{
            if emotions != nil{
                return true
            }
            return false
        }
    }
    var flagWriting:Bool{
        get{
            if writing != nil{
                return true
            }
            return false
        }
    }
    
    
    
   fileprivate var emotions:[String:Any]?{
        
        willSet{
            
        }
        
        didSet{
            print("Emotions")
            print("")
            print(emotions!)
            print("")
        }
    }
    
    
    
    fileprivate var writing:[String:Any]? {
            
            
//            let r = self.writing as! [String:[[[String:Double]]]]
//            return r.mapValues({ (stuff) -> [String:[[String:Double]]] in
//                for (key,value) in stuff{
//                    return [key:value[0]]
//                }
//            })
            
            
           
    
//        }
//
//        set{
//            self.writing = newValue
//
//        }
//
        willSet{

        }

        didSet{
            print("Writing")
            print("")
            print(writing!)
            print("")
        }
        
    }
    
    fileprivate var social:[String:Any]?{
        
        
        willSet{
            
        }
        
        didSet{
            print("Social")
            print("")
            print(social!)
            print("")
            
        }
    }
    
    
    
    
    var connectivity:Bool{
        
        get{
            if Reachability.isConnectedToNetwork(){
                return true
                //                print("Internet Connection Available!")
            }else{
                return false
                //                print("Internet Connection not Available!")
            }
        }
        
    }
    
    
    func reset() {
        social = nil
        emotions = nil
        writing = nil
    }
    func getSocialTones(textToBeAnalyzed textToBeProcessed:String) {
        if (connectivity){
            analyzes(textToBeAnalyzed: textToBeProcessed, tones: ["social"], sentences: false, failFunction: { (error: Error) in print(error) }, type: "social")
            
        }
        print("no internet")
        
        
    }
    
    func getEmotionalTones(textToBeAnalyzed textToBeProcessed:String ){
        if (connectivity){
            analyzes(textToBeAnalyzed: textToBeProcessed, tones: ["emotion"], sentences: false, failFunction: { (error: Error) in print(error) }, type: "emotion")
            
        }
        print("no internet")
        
        
    }
    
    func getWritingTones(textToBeAnalyzed textToBeProcessed:String,bySentnece:Bool ){
        if (connectivity){
            analyzes(textToBeAnalyzed: textToBeProcessed, tones: ["writing"], sentences: bySentnece, failFunction: { (error: Error) in print(error) }, type: "writing")
        }
        print("no internet")
    }
    
    
    func analyzes(textToBeAnalyzed textToBeProcessed: String, tones : [String],sentences: Bool, failFunction: @escaping (Error) -> Void, type: String){
        var dict = Dictionary<String, Any>()
        ToneAnalyzes.getTone(ofText: textToBeProcessed, tones: tones, sentences: sentences, failure: failFunction){[weak self]tone in
            withExtendedLifetime(self){
                if let weakSelf = self{
                    if (!sentences){
                        for t in tone.documentTone[0].tones{
                            dict[t.name] = t.score
                        }
                    }
                    else{
                        for t in tone.sentencesTones!{
                            dict[t.text] = t.toneCategories.map({ (toncat) -> Any in
                                return toncat.tones.map({ (tonescore) -> Any in
                                return[tonescore.name:tonescore.score]
                                })
                            })
                            
                            }
                        }
                    switch type{
                    case "emotion":
                        weakSelf.emotions = dict
                    case "social":
                        weakSelf.social = dict
                    case "writing":
                        weakSelf.writing = dict
                    default:
                        print("no tones found")
                    }
                }
            }
         }
        }
        
        
    }

