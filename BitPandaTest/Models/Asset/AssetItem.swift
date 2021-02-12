//
//  ListItemModel.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import Foundation

struct AssetItem : Codable {
    let type : String?
    let attributes : Attributes?
    let id : String?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case attributes = "attributes"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}
