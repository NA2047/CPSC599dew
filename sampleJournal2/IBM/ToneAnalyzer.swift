//
//  ToneAnalyzer.swift
//  ToneAnalyzer

//
// This class is designed to enable the usage of IBM ToneAnalyzerV3
// particularly for the following functionality
// Tone analysis results of the entire document's text. This includes three
// tone categories: social tone, emotional tone, and language tone.
// public let documentTone: [ToneAnalyzerV3.ToneCategory]

/// Tone analysis results for each sentence contained in the document.
//  public let sentencesTones: [ToneAnalyzerV3.SentenceAnalysis]?
//
//

import Foundation
import ToneAnalyzerV3

class Tones{
    /**
     This emotions variable is used as a private storage after getToneTypes for emotions
     */
    fileprivate var emotions:[String:Any]?
    /**
     This writing style variable is used as a private storage after getToneTypes for emotions
     */
    fileprivate var writing:[String:Any]?
    /**
      This social styles variable is used as a private storage after getToneTypes for emotions
     */
    fileprivate var social:[String:Any]?
    
    /**
     instance of ToneAnalyzer used for all API calls
     */
    let ToneAnalyzes:ToneAnalyzer = ToneAnalyzer(username: "7ed26589-b179-4365-b91f-836a6b9af90c", password: "utIZLIYCNQwD", version: "2017-07-06")
    
    /**
     This computed variable is used for both setting the sting to be analzyed and getting the
     sting after the Watson SDK has parsed the JSON
     
     -usage Tones.socialDocumentTones = "Text to be anaylized"
     if let tone = Tones.socialDocumentTones {
        do something with the return type
     }
     */
    var socialDocumentTones:Any?{
        get{
            if let value = social {
                return value
            }
            return nil
        }
        set{
            if newValue is String {
                getToneTypes(textToBeAnalyzed: newValue as! String, tones: ["social"],sentence: false)
            }
            
        }
    }
    
    /**
     This computed variable is used for both setting the sting to be analzyed and getting the
     sting after the Watson SDK has parsed the JSON
     
     -usage Tones.emotionDocumentTones = "Text to be anaylized"
     if let tone = Tones.emotionDocumentTones {
     do something with the return type
     }
     */
    var emotionDocumentTones:Any?{
        
        get{
            if let value = emotions {
                return value
            }
            return nil
        }
        set{
            if newValue is String {
                getToneTypes(textToBeAnalyzed: newValue as! String, tones: ["emotion"],sentence: false)
            }
            
        }
        
    }
    /**
     This computed variable is used for both setting the sting to be analzyed and getting the
     sting after the Watson SDK has parsed the JSON
     
     -usage Tones.writingDocumentTones = "Text to be anaylized"
     if let tone = Tones.writingDocumentTones {
     do something with the return type
     }
     */
    var writingDocumentTones:Any?{
        get{
            if let value = writing {
                return value
            }
            return nil
        }
        set{
            if newValue is String {
                getToneTypes(textToBeAnalyzed: newValue as! String, tones: ["writing"],sentence: false)
            }
            
        }
    }
    
    /**
    this variable is used to check to see if device has internet
     */
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
    
    // used as a hard rest on variables
    func reset() {
        social = nil
        emotions = nil
        writing = nil
    }
    
    deinit {
        social = nil
        emotions = nil
        writing = nil
        
    }
    
    /**
     This function takes a String to be Anayzed the type of tone to retrive and if each sentence should be anaysed or the document in its entiretly
     
     - parameter textToBeAnalyzed: String to be analyzed
     - parameter tones: tones to look for eg ["emotion","social"]
     - parameter sentence: flag to check the enitre string or each sentence in the string
     */
    func getToneTypes(textToBeAnalyzed textToBeProcessed:String,tones: [String],sentence: Bool) {
        if (connectivity){
            analyzes(textToBeAnalyzed: textToBeProcessed, tones: tones, sentences: sentence, failFunction: { (error: Error) in print(error) }, type: tones[0])
        }
        else{
            print("no internet")
        }
    }
    
    
    /**
     This function makes the call to IBM Watson and retrive the data from the returned JSON
     
     - parameter textToBeAnalyzed: String to be analyzed
     - parameter tones: tones to look for eg ["emotion","social"]
     - parameter sentence: flag to check the enitre string or each sentence in the string
     */
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
                                    return[tonescore.name:tonescore.score]})})
                            
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

