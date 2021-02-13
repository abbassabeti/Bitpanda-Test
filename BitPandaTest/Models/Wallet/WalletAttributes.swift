//
//  WalletAttributes.swift
//  BitPandaTest
//
//  Created by Abbas on 2/12/21.
//

import Foundation

struct WalletAttributes: Codable {
    let cryptocoinID, cryptocoinSymbol: String?
    let balance: Float64?
    let isDefault: Bool?
    let name: String?
    let pendingTransactionsCount: Int?
    let deleted: Bool?

    enum CodingKeys: String, CodingKey {
        case cryptocoinID = "cryptocoin_id"
        case cryptocoinSymbol = "cryptocoin_symbol"
        case balance
        case isDefault = "is_default"
        case name
        case pendingTransactionsCount = "pending_transactions_count"
        case deleted
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cryptocoinID = try values.decodeIfPresent(String.self, forKey: .cryptocoinID)
        cryptocoinSymbol = try values.decodeIfPresent(String.self, forKey: .cryptocoinSymbol)
        if let balanceStr = try values.decodeIfPresent(String.self, forKey: .balance){
            balance = Float64(balanceStr)
        }else{
            balance = nil
        }
        isDefault = try values.decodeIfPresent(Bool.self, forKey: .isDefault)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        pendingTransactionsCount = try values.decodeIfPresent(Int.self, forKey: .pendingTransactionsCount)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
    }
}


extension WalletAttributes : Equatable {
    static func == (lhs: WalletAttributes, rhs: WalletAttributes) -> Bool {
        return lhs.cryptocoinID == rhs.cryptocoinID &&
            lhs.cryptocoinSymbol == rhs.cryptocoinSymbol &&
            lhs.balance == rhs.balance &&
            lhs.name == rhs.name &&
            lhs.pendingTransactionsCount == rhs.pendingTransactionsCount &&
            lhs.deleted == rhs.deleted
    }
}
