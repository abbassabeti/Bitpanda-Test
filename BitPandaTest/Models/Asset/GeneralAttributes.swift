//
//  AssetAttributes.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import Foundation
struct GeneralAttributes : Codable {
    let cryptocoins : [AssetItem?]?
    let commodities : [AssetItem?]?
    let fiats : [AssetItem?]?
    let wallets : [WalletItem?]?
    let commodityWallets : [WalletItem?]?
    let fiatWallets : [FiatWalletItem?]?

    enum CodingKeys: String, CodingKey {

        case cryptocoins = "cryptocoins"
        case commodities = "commodities"
        case fiats = "fiats"
        case wallets = "wallets"
        case commodityWallets = "commodity_wallets"
        case fiatWallets = "fiatwallets"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cryptocoins = try values.decodeIfPresent([AssetItem].self, forKey: .cryptocoins)
        commodities = try values.decodeIfPresent([AssetItem].self, forKey: .commodities)
        fiats = try values.decodeIfPresent([AssetItem].self, forKey: .fiats)
        wallets = try values.decodeIfPresent([WalletItem].self, forKey: .wallets)
        commodityWallets = try values.decodeIfPresent([WalletItem].self, forKey: .commodityWallets)
        fiatWallets = try values.decodeIfPresent([FiatWalletItem].self, forKey: .fiatWallets)
    }

}
