//
//  FiatWalletAttributes.swift
//  BitPandaTest
//
//  Created by Abbas on 2/12/21.
//

import Foundation

struct FiatWalletAttributes: Codable {
    let fiatID, fiatSymbol, name: String?
    let balance : Float64?
    let pendingTransactionsCount: Int?

    enum CodingKeys: String, CodingKey {
        case fiatID = "fiat_id"
        case fiatSymbol = "fiat_symbol"
        case balance, name
        case pendingTransactionsCount = "pending_transactions_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fiatID = try values.decodeIfPresent(String.self, forKey: .fiatID)
        fiatSymbol = try values.decodeIfPresent(String.self, forKey: .fiatSymbol)
        if let balanceStr = try values.decodeIfPresent(String.self, forKey: .balance){
            balance = Float64(balanceStr)
        }else{
            balance = nil
        }
        name = try values.decodeIfPresent(String.self, forKey: .name)
        pendingTransactionsCount = try values.decodeIfPresent(Int.self, forKey: .pendingTransactionsCount)
    }
}
