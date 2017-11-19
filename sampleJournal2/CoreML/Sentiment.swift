import UIKit

enum Sentiment {
    case neutral
    case positive
    case negative
    
    var emoji: String {
        switch self {
        case .neutral:
            return "neutral"
        case .positive:
            return "positive"
        case .negative:
            return "negative"
        }
    }
    
//    var color: UIColor? {
//        switch self {
//        case .neutral:
//            return UIColor(named: "NeutralColor")
//        case .positive:
//            return UIColor(named: "PositiveColor")
//        case .negative:
//            return UIColor(named: "NegativeColor")
//        }
    }


