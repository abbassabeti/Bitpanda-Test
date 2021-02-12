//
//  MasterData.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import Foundation

// MARK: - MasterData
struct MasterData: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let type: String?
    let attributes: GeneralAttributes?
}
