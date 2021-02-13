//
//  WalletAssetItem.swift
//  BitPandaTest
//
//  Created by Abbas on 2/12/21.
//

import Foundation

struct WalletItem : Codable {
    let type : String?
    let attributes : WalletAttributes?
    let id : String?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case attributes = "attributes"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        attributes = try values.decodeIfPresent(WalletAttributes.self, forKey: .attributes)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}

extension WalletItem : Equatable {
    static func == (lhs: WalletItem, rhs: WalletItem) -> Bool {
        return lhs.attributes == rhs.attributes &&
            lhs.id == rhs.id &&
            lhs.type == rhs.type
    }
}
