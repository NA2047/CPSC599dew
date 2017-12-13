//
//  LinguisticWrapper.swift
//  BackEndModels
//
//  TODO - ANDREW: give a description of what this class does
//  TODO - ANDREW: provide more documentation on what the code does
//  TODO - ANDREW: remove unnecessary code, fix typos

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
    
    var sentences: [String]?{
        get{
            var range = [Range<String.Index>]()
            let tagger = self.linguisticTags(in: self.startIndex..<self.endIndex, scheme: NSLinguisticTagScheme.lexicalClass.rawValue,options:[.omitWhitespace],tokenRanges:&range)
            var result = [String]()
            print(result)
            let ixs = tagger.enumerated().filter {$0.1 == "SentenceTerminator"}.map {range[$0.0].lowerBound}
            print(ixs)
            var prev = self.startIndex
            for ix in ixs {
                let rangeS = prev...ix
                result.append(self[rangeS].trimmingCharacters(in: NSCharacterSet.whitespaces))
                prev = self.index(after: ix)
            }
            return result
            
        }
    }

    var predispostion: [String]?{
        get{
            if (self == ""){
                return nil
            }
            else{
                let vebs = computed(tag: .noun)
                if let result = vebs[String(describing: NSLinguisticTag.preposition)]{
                    return result
                }
            }
            return nil
        }
    }
    var adverbs: [String]?{
        get{
            if (self == ""){
                return nil
            }
            else{
                let vebs = computed(tag: .noun)
                if let result = vebs[String(describing: NSLinguisticTag.adverb)]{
                    return result
                }
            }
            return nil
        }
    }
    
    var idioms: [String]?{
        get{
            if (self == ""){
                return nil
            }
            else{
                let vebs = computed(tag: .noun)
                if let result = vebs[String(describing: NSLinguisticTag.idiom)]{
                    return result
                }
            }
            return nil
        }
    }
    
    var nouns: [String]?{
        get{
            if (self == ""){
                return nil
            }
            else{
                let vebs = computed(tag: .noun)
                if let result = vebs[String(describing: NSLinguisticTag.noun)]{
                    return result
                }
            }
            return nil
        }
    }
    
    
    var pronouns: [String]?{

        get{
            if (self == ""){
                return nil
            }
            else{
                let vebs = computed(tag: .pronoun)
                if let result = vebs[String(describing: NSLinguisticTag.pronoun)]{
                    return result
                }
            }
            return nil
        }

    }
    
    var adjectives: [String]?{
        get{
            if (self == ""){
                return nil
            }
            else{
                let vebs = computed(tag: .adjective)
                if let result = vebs[String(describing: NSLinguisticTag.adjective)]{
                    return result
                }
            }
            return nil
        }
    }
  
    
    
    var verbs: [String]? {
        get{
            if (self == ""){
                return nil
            }
            else{
                let vebs = computed(tag: .verb)
                if let result = vebs[String(describing: NSLinguisticTag.verb)]{
                    return result
                }
            }
            return nil
        }
    }
    
    var personalNames: [String]?{
        get{
            if (self == ""){
                return nil
            }
            let names = computed(tag: .personalName,linguisticTagScheme: .nameType)
            if let result = names[String(describing: NSLinguisticTag.personalName)]{
                return result
            }
            return nil
        }
    }
    
    
    

    
    var organizationName: [String]?{
        get{
            if (self == ""){
                return nil
            }
            let names = computed(tag: .organizationName,linguisticTagScheme: .nameType)
            if let result = names[String(describing: NSLinguisticTag.organizationName)]{
                return result
            }
            return nil
        }
    }
    
    var placeName: [String]?{
        get{
            if (self == ""){
                return nil
            }
            let names = computed(tag: .placeName,linguisticTagScheme: .nameType)
            if let result = names[String(describing: NSLinguisticTag.placeName)]{
                return result
            }
            return nil
        }
        
        
    }

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
        
        var arraySentences1 = [String]()
        var arraySentences = [String:[String]]()
        let tagger = NSLinguisticTagger(tagSchemes: [tagSchema],options: taggerOptions)
        tagger.string = processString
        let range = NSRange(location: 0, length: processString.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: tagSchema, options: omitOptions) { tag, tokenRange, _ in
            guard let tag = tag, tags.contains(tag) else { return }
            let token = ( processString as NSString).substring(with: tokenRange)
            arraySentences1.append(token)
        }
        arraySentences[String(describing: tags[0])] = arraySentences1
       
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

        let tags =  parseText(processString: self,tagSchema: .lexicalClass,taggerOptions: 0,omitOptions: [.omitPunctuation,.omitWhitespace],tags: [tag])
        return tags
    }

    func computed(tag:NSLinguisticTag, linguisticTagScheme: NSLinguisticTagScheme) -> [String:[String]]{
        let tags =  parseText(processString: self,tagSchema: linguisticTagScheme,taggerOptions: 0,omitOptions: [.omitPunctuation,.omitWhitespace],tags: [tag])
        return tags
       

    }
    
    func computed(tagSchema : NSLinguisticTagScheme, taggerOptions: Int, omitOptions: NSLinguisticTagger.Options,tags: [NSLinguisticTag]) -> [String:[String]]{
        var results = [String:[String]]()
        for tag in tags{
            let gather =  parseText(processString: self, tagSchema: tagSchema,taggerOptions: taggerOptions, omitOptions: omitOptions, tags: [tag])
            results.merge(dict: gather)
        }
        return results
    }

    
    typealias TaggedToken = (String, String?)
    
    func tag(text: String, scheme: String) -> [TaggedToken] {
        let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .omitOther]
        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"),
        options: Int(options.rawValue))
        tagger.string = text
        var tokens: [TaggedToken] = []
        
        let range = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: range, scheme:NSLinguisticTagScheme(rawValue: scheme), options: options) { tag, tokenRange, _, _ in
            let token = (text as NSString).substring(with: tokenRange)
            tokens.append((token, tag.map { $0.rawValue }))
        }
        return tokens
    }
    
    
   
    
    
    
    // Implementation
    
    func partOfSpeech() -> [TaggedToken] {
        return tag(text: self, scheme:NSLinguisticTagScheme.lexicalClass.rawValue)
    }
    
    func lemmatize() -> [TaggedToken] {
        return tag(text: self, scheme: NSLinguisticTagScheme.lemma.rawValue)
    }
    
    func language() -> [TaggedToken] {
        return tag(text: self, scheme: NSLinguisticTagScheme.language.rawValue)
    }
    


}

