//
//  AssetViewModel.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import Foundation

class AssetViewModel {
    
    var cryptoCoins : [AssetItem]
    var commodities : [AssetItem]
    var fiats : [AssetItem]
    var type : AssetType
    var showSectionHeader : Bool = true
    var showFloaty: Bool = true

    init(cryptocoins: [AssetItem],commodities: [AssetItem],fiats:[AssetItem],type: AssetType = .All,showSectionHeader: Bool = true,showFloaty: Bool = true){
        self.cryptoCoins = cryptocoins
        self.commodities = commodities
        self.fiats = fiats
        self.type = type
        self.showSectionHeader = showSectionHeader
        self.showFloaty = showFloaty
    }
    
    func getCorrespondingGroup(type: AssetType? = nil) -> [AssetItem]{
        switch type ?? self.type {
        case .Commodity:
            return commodities
        case .Cryptocoin:
            return cryptoCoins
        case .Fiat:
            return fiats
        default:
            return []
        }
    }
}
