//
//  WalletType.swift
//  BitPandaTest
//
//  Created by Abbas on 2/12/21.
//

import Foundation

enum WalletType : String, Codable{
    case Wallet = "wallet"
    case CommodityWallet = "commodity_wallet"
    case FiatWallet = "fiat_wallet"
    case All = "all"
    
    func getTitleName() -> String{
        switch self {
            case .Wallet:
                return LocalizedString("wallets_name")
            case .CommodityWallet:
                return LocalizedString("commodity_wallets_name")
            case .FiatWallet:
                return LocalizedString("fiat_wallets_name")
            default:
                return LocalizedString("all_name")
        }
    }
}
