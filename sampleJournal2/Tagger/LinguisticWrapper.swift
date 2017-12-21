//
//  LinguisticWrapper.swift
//
//


import Foundation


// This extension provides a wrapper for the NSLingisticTagger and adds some of the functionality to the String class
extension String{
    
    
    
    
    
    /**
     Analyze the given text.
     
     The text can be analyzed for and will return all verbs,nouns,predispostions, etc
     
     - parameter tags: A array of NSLinguisticTags eg. [.noun,.verb].
     - returns: A new optional Dictionary of type [String:[String]]?
     */
    func generticTagger(tags : [NSLinguisticTag]) -> [String:[String]]? {
        var ts = [String:[String]]()
        for tag in tags{
            ts[String(describing: tag)] = parseText(processString: self, tagSchema : .lexicalClass, taggerOptions: 0, omitOptions: [.omitWhitespace,.omitPunctuation],tags: [tag])[String(describing: tag)]
        }
        print(ts)
        return ts
    }
    /**
     Analyze the given text.
     
     This computed varibale returns all senetneces wihtin a paragraph or string
     
     */
    var sentences: [String]?{
        get{
            var ranges = [Range<String.Index>]()
            let tagger = self.linguisticTags(in: self.startIndex..<self.endIndex, scheme: NSLinguisticTagScheme.lexicalClass.rawValue,options:[.omitWhitespace],tokenRanges:&ranges)
            var result = [String]()
            let terminators = tagger.enumerated().filter {$0.1 == "SentenceTerminator"}.map {ranges[$0.0].lowerBound}
            var prev = self.startIndex
            for index in terminators {
                let terminatorRange = prev...index
                result.append(self[terminatorRange].trimmingCharacters(in: NSCharacterSet.whitespaces))
                prev = self.index(after: index)
            }
            return result
            
        }
    }
    
    
    var words:[String]?{
        
        get{
            let options: NSLinguisticTagger.Options = [.omitWhitespace]
            let scheme = [NSLinguisticTagScheme.lexicalClass]
            let tagger = NSLinguisticTagger(tagSchemes: scheme, options: Int(options.rawValue))
            let range = NSMakeRange(0, (self as NSString).length)
            tagger.string = self
            var parts : [String] = []
            tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange, _ in
                let token = (self as NSString).substring(with :tokenRange)
                parts.append(token)
            }
            return parts
        }
        
        
        
    }
    
    /**
     Analyze the given text.
     
     This computed varibale returns all predispostion wihtin a String
     
     */
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
    /**
     Analyze the given text.
     
     This computed varibale returns all adverbs wihtin a String
     
     */
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
    /**
     Analyze the given text.
     
     This computed varibale returns all idioms wihtin a String
     
     */
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
    /**
     Analyze the given text.
     
     This computed varibale returns all nouns wihtin a String
     
     */
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
    
    /**
     Analyze the given text.
     
     This computed varibale returns all pronouns wihtin a String
     
     */
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
    /**
     Analyze the given text.
     
     This computed varibale returns all adjectives wihtin a String
     
     */
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
    
    
    /**
     Analyze the given text.
     
     This computed varibale returns all verbs wihtin a String
     
     */
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
    /**
     Analyze the given text.
     
     This computed varibale returns all personal names wihtin a String
     
     */
    var personalNames: [String]?{
        get{
            if (self == ""){
                return nil
            }
            let names = computed(tags: .personalName,linguisticTagScheme: .nameType)
            if let result = names[String(describing: NSLinguisticTag.personalName)]{
                return result
            }
            return nil
        }
    }
    
    
    
    
    /**
     Analyze the given text.
     
     This computed varibale returns all organization names wihtin a String
     
     */
    var organizationNames: [String]?{
        get{
            if (self == ""){
                return nil
            }
            let names = computed(tags: .organizationName,linguisticTagScheme: .nameType)
            if let result = names[String(describing: NSLinguisticTag.organizationName)]{
                return result
            }
            return nil
        }
    }
    /**
     Analyze the given text.
     
     This computed varibale returns all place names wihtin a String
     
     */
    var placeNames: [String]?{
        get{
            if (self == ""){
                return nil
            }
            let names = computed(tags: .placeName,linguisticTagScheme: .nameType)
            if let result = names[String(describing: NSLinguisticTag.placeName)]{
                return result
            }
            return nil
        }
        
        
    }
    /**
     Analyze the given text.
     
     This computed varibale returns dominant language wihtin a String
     
     */
    var dominantLanguage: String {
        get{
            
            let tagger = NSLinguisticTagger(tagSchemes: [.lexicalClass],options: 0)
            tagger.string = self
            if let dom = tagger.dominantLanguage{
                return dom
            }
            else{
                precondition(tagger.dominantLanguage == nil, "much bigger problem with your domLang")
            }
            return "should not get here, if you are you got a problem"
        }
    }
    
    
    /**
     Analyze the given text. This function is more full fetured and can use the full power of the NSLinguisticTagger
     
     This function is used to simplfy the process of calling NSLinguisticTagger
     - parameter processString: string to be passed to the NSLinguisticTagger
     - parameter tagSchema: this tells the NSLinguisticTagger what to look for, with the most common being nameType, lexicalClass, lemma
     - parameter taggerOptions: not yet implemented , future updates to swift will add functionality
     - parameter omitOptions: these are areas where the NSLinguisticTagger should skip withint the string   eg. [.omitPunctuation,.omitWhitespace].
     - parameter tags: an array of NSLinguisticTags of what to look for in the String eg. [.noun,.verb].
     
     - returns: A new Dictionary of type [String:[String]]
     */
    func parseText(processString: String, tagSchema : NSLinguisticTagScheme, taggerOptions: Int, omitOptions: NSLinguisticTagger.Options,tags: [NSLinguisticTag]) -> [String:[String]] {
        
        var arraySentences1 = [String]()
        var arraySentences = [String:[String]]()
        let tagger = NSLinguisticTagger(tagSchemes: [tagSchema],options: taggerOptions)
        tagger.string = processString
        let range = NSRange(location: 0, length: processString.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: tagSchema, options: omitOptions) { tag, tokenRange, _ in
            guard let tag = tag, tags.contains(tag) else { return }
            //            print(tag)
            let token = ( processString as NSString).substring(with: tokenRange)
            arraySentences1.append(token)
        }
        arraySentences[String(describing: tags[0])] = arraySentences1
        
        return arraySentences
    }
    
    /**
     
     
     This function is used to remove Strings based on a pattern from the calling String
     
     - parameter pattern: regular expression pattern to match a remove
     - parameter replaceWith: what string to replaced removed string with default is ""
     */
    mutating func removingRegexMatches(pattern: String, replaceWith: String = "") {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.utf16.count)
            self = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return
        }
    }
    
    /**
     This function is used return only taged strings that are needed from the tagSchema
     .lexicalClass
     
     - parameter tags: an array of NSLinguisticTags eg. [.noun,.verb].
     - returns: A new Dictionary of type [String:[String]]
     */
    func computed(tag:NSLinguisticTag) -> [String:[String]]{
        
        let tags =  parseText(processString: self,tagSchema: .lexicalClass,taggerOptions: 0,omitOptions: [.omitPunctuation,.omitWhitespace],tags: [tag])
        return tags
    }
    /**
     This function is used return only taged strings that are needed from the tagSchema
     but can also choose which NSLinguisticTagScheme to use
     
     - parameter tags: an array of NSLinguisticTags eg. [.noun,.verb].
     - parameter linguisticTagScheme: this tells the NSLinguisticTagger what to look for, with the most common being nameType, lexicalClass, lemma
     - returns: A new Dictionary of type [String:[String]]
     */
    func computed(tags:NSLinguisticTag, linguisticTagScheme: NSLinguisticTagScheme) -> [String:[String]]{
        let tags =  parseText(processString: self,tagSchema: linguisticTagScheme,taggerOptions: 0,omitOptions: [.omitPunctuation,.omitWhitespace],tags: [tags])
        return tags
        
        
    }
    
    func mergeTagger(tagSchema : NSLinguisticTagScheme, taggerOptions: Int, omitOptions: NSLinguisticTagger.Options,tags: [NSLinguisticTag]) -> [String:[String]]{
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

