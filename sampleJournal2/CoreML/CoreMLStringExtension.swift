//
//  CoreMLExtension.swift
//  599 Prototype
//
// These extentions are used to access the coreML model called sentimentPolarity which allows users to call functions are use an interal private class that use the CoreML model to generate a decision on wether the string is positive, neative or netural

//  Created by Vadym Markov
//  Refference https://github.com/cocoa-ai/SentimentCoreMLDemo
//MIT License
//A short and simple permissive license with conditions only requiring preservation of copyright and license notices. Licensed works, modifications, and larger works may be distributed under different terms and without source code.
//Permissions:
    //Commercial use
    //Modification
    //Distribution
    //Private use

import Foundation




extension String: Error{
    
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
    
    func getSetimentProbabilities()->(Double,Double){
        let classificationService = ClassificationService()
        let result = classificationService.getProp(from: self)
        return result
    }
    
    
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
        func getProp(from text: String) -> (Double,Double) {
            do {
                let inputFeatures = features(from: text)
                
                print(inputFeatures)
                // Make prediction only with 2 or more words
                guard inputFeatures.count > 1 else {
                    throw Error.featuresMissing
                }
                
                let output = try model.prediction(input: inputFeatures)
                return (output.classProbability["Pos"]!,output.classProbability["Neg"]!)
               
            }
            catch {
                return (0.0,0.0)
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
