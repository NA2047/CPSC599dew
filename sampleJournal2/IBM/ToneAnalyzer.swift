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
    //
    fileprivate var emotions:[String:Any]?
    fileprivate var writing:[String:Any]?
    fileprivate var social:[String:Any]?
    
    
    let ToneAnalyzes:ToneAnalyzer = ToneAnalyzer(username: "7ed26589-b179-4365-b91f-836a6b9af90c", password: "utIZLIYCNQwD", version: "2017-07-06")
    
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
        <#statements#>
    }
    
    
    func getToneTypes(textToBeAnalyzed textToBeProcessed:String,tones: [String],sentence: Bool) {
        if (connectivity){
            analyzes(textToBeAnalyzed: textToBeProcessed, tones: tones, sentences: sentence, failFunction: { (error: Error) in print(error) }, type: tones[0])
        }
        else{
            print("no internet")
        }
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

