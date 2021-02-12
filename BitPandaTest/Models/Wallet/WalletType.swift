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
}
