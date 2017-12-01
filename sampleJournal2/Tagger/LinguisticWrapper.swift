//
//  LinguisticWrapper.swift
//  BackEndModels
//
//  Created by Andrew on 2017-11-01.
//  Copyright © 2017 Andrew. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}

extension String{
//    private enum type{
//        case verb
//        case noun
//        case adjective
//        case adverb
//        case pronoun
//        case determiner
//        case particle
//        case predispostion
//        case number
//        case conjunction
//        case interjection
//        case classifier
//        case idiom
//    }
    
  
    
    
    var verbs: [String] {
        get{
            let vebs = computed(tag: .verb)
            if let result = vebs["verbs"]{
                return result
            }
            else{
                precondition(vebs["verbs"] == nil, "much bigger problem with the verbs var")
            }
             return ["you", "are", "not","suppose","to","be","here"]
        }
        set{
            
            
        }
    }
    
    
    
//    var noun: [String]{
//
//    }
    
    
    
    var dominantLanguage: String {
        get{
            let tagger = NSLinguisticTagger(tagSchemes: [.lexicalClass],options: 0)
            tagger.string = self
            if let dom = tagger.dominantLanguage{
                return dom
            }
            else{
                precondition(tagger.dominantLanguage == nil, "much bigger problem iwht your domLang")
            }
            return "should not get here, if you are you got a problem"
        }
    }
    
    func parseText(processString: String, tagSchema : NSLinguisticTagScheme, taggerOptions: Int, omitOptions: NSLinguisticTagger.Options,tags: [NSLinguisticTag]) -> [String:[String]] {
        
        var arraySentences = [String:[String]]()
        let tagger = NSLinguisticTagger(tagSchemes: [tagSchema],options: taggerOptions)
        tagger.string = processString
        
        let range = NSRange(location: 0, length: processString.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: tagSchema, options: omitOptions) { tag, tokenRange, _ in
            guard let tag = tag, tags.contains(tag) else { return }
            let token = ( processString as NSString).substring(with: tokenRange)
            if var val = arraySentences[token]{
                val.append(tag.rawValue)
            }
            else{
                arraySentences[token]?.append(tag.rawValue)
            }
        }
        return arraySentences
    }
    
    mutating func removingRegexMatches(pattern: String, replaceWith: String = "") {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.utf16.count)
            self = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return
        }
        
    }
   
    func computed(tag:NSLinguisticTag) -> [String:[String]]{
        let key = String(describing: tag)
        let vebs =  parseText(processString: self,tagSchema: .lexicalClass,taggerOptions: 0,omitOptions: [.omitPunctuation,.omitWhitespace],tags: [tag])
        
        return vebs
    }
    
    func computed(tagSchema : NSLinguisticTagScheme, taggerOptions: Int, omitOptions: NSLinguisticTagger.Options,tags: [NSLinguisticTag]) -> [String:[String]]{
        var results = [String:[String]]()
        for tag in tags{
            let gather =  parseText(processString: self,tagSchema: tagSchema,taggerOptions: taggerOptions,omitOptions: omitOptions,tags: [tag])
            results.merge(dict: gather)
        }
        return results
    }
    
    

}

