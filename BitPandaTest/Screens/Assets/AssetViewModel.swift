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
    
    init(cryptocoins: [AssetItem],commodities: [AssetItem],fiats:[AssetItem]){
        self.cryptoCoins = cryptocoins
        self.commodities = commodities
        self.fiats = fiats.filter({$0.attributes?.hasWallets ?? false})
        self.type = .All
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
