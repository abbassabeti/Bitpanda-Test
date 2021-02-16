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
                return LocalizedString("cryptocoins_name")
            case .Commodity:
                return LocalizedString("commodities_name")
            case .Fiat:
                return LocalizedString("fiats_name")
            default:
                return LocalizedString("all_name")
        }
    }
}
