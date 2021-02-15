//
//  AssetType.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import Foundation

enum AssetType : String, Codable{
    case Cryptocoin = "cryptocoin"
    case Commodity = "commodity"
    case Fiat = "fiat"
    case All = "all"
    
    func getTitleName() -> String{
        switch self {
            case .Cryptocoin:
                return "Cryptocoins"
            case .Commodity:
                return "Commodities"
            case .Fiat:
                return "Fiats"
            default:
                return "All"
        }
    }
}
