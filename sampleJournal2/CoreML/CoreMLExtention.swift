//
//  CoreMLExtention.swift
//  599 Prototype
//
//  TODO - ANDREW: give a description of what this class does
//  TODO - ANDREW: fix the typo in the naming of this file
//  TODO - ANDREW: provide more documentation for your code, fix typos
//

import Foundation
import UIKit

extension Array where Element: NSAttributedString {
    func joined(separator: NSMutableAttributedString) -> NSMutableAttributedString {
        var isFirst = true
        //  TODO - ANDREW: perhaps use better names than 'r' and 'e'
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(separator: String) -> NSMutableAttributedString {
        return joined(separator: NSMutableAttributedString(string: separator))
    }
}

extension String: Error{
    func getColorForEmotion(wordToColor: String) {
        let range = (self as NSString).range(of: wordToColor)
        
        let attribute = NSMutableAttributedString.init(string: self)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
    }
    
    enum Sentiment {
        case neutral
        case positive
        case negative
        
        var rawValue: String {
            switch self {
            case .neutral:
                return "neutral"
            case .positive:
                return "positive"
            case .negative:
                return "negative"
            }
        }
        
        var color: UIColor? {
            switch self {
            case .neutral:
                return UIColor(named: "NeutralColor")
            case .positive:
                return UIColor(named: "PositiveColor")
            case .negative:
                return UIColor(named: "NegativeColor")
            }
        }
        
        var emoji: String {
            switch self {
            case .neutral:
                return "😐"
            case .positive:
                return "😃"
            case .negative:
                return "😔"
            }
        }
}

    func performJournalAnalysis() -> (String, String, String)  {
        let classificationService = ClassificationService()
        let result = classificationService.predictSentiment(from: self )
        let result2 = result.0.rawValue
        return (result2, String(result.1), result.0.emoji)
    }
    
    func getSentiment() ->String{
        let classificationService = ClassificationService()
        let result = classificationService.predictSentiment(from: self )
        return result.0.rawValue
        
    }
    func getSetimentProbability()->Double{
        let classificationService = ClassificationService()
        let result = classificationService.predictSentiment(from: self )
        return result.1
    }
    
//    func getSetimentProbabilities()->(Double,Double){
//        let classificationService = ClassificationService()
//        let result = classificationService.predictSentiment(from: self)
//        return result
//    }
//
    
//    func getWords() -> [String: Double]{
//        return ClassificationService.features()
//
//    }
    
    
    private final class ClassificationService {
        private enum Error: Swift.Error {
            case featuresMissing
        }
        
        private let model = SentimentPolarity()
        private let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .omitOther]
        private lazy var tagger: NSLinguisticTagger = .init(
            tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"),
            options: Int(self.options.rawValue)
        )
        
        // MARK: - Prediction
        
        //  TODO - ANDREW: is this function still necessary?
        //                 If so, the typo should be fixed.
        //                 Otherwise, please remove the function.
        func getProbalities(){
    
        }
        
        func predictSentiment(from text: String) -> (Sentiment,Double) {
            do {
                let inputFeatures = features(from: text)
                print(inputFeatures)
                // Make prediction only with 2 or more words
                guard inputFeatures.count > 1 else {
                    throw Error.featuresMissing
                }
                
                let output = try model.prediction(input: inputFeatures)
                
                switch output.classLabel {
                case "Pos":
                    return (.positive,output.classProbability["Pos"]!)
                case "Neg":
                    return (.negative,output.classProbability["Neg"]!)
                default:
                    return (.neutral,1.1)
                }
            }
            catch {
                return (.neutral,0.0)
            }
        }
        
        
         func features(from text: String) -> [String: Double] {
            var wordCounts = [String: Double]()
            
            tagger.string = text
            let range = NSRange(location: 0, length: text.utf16.count)
            
            // Tokenize and count the sentence
            tagger.enumerateTags(in: range, scheme: .nameType, options: options) { _, tokenRange, _, _ in
                let token = (text as NSString).substring(with: tokenRange).lowercased()
                // Skip small words
                guard token.count >= 3 else {
                    return
                }
                if let value = wordCounts[token] {
                    wordCounts[token] = value + 1.0
                } else {
                    wordCounts[token] = 1.0
                }
            }
            return wordCounts
        }
    }
}
