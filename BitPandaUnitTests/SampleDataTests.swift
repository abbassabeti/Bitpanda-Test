//
//  PriceTests.swift
//  BitPandaUnitTests
//
//  Created by Abbas on 2/14/21.
//

import XCTest
@testable import BitPandaTest

class SampleDataTests: XCTestCase {
    var coordinator : MainCoordinator!
    override func setUpWithError() throws {
        coordinator = MainCoordinator()
    }

    override func tearDownWithError() throws {
        coordinator = nil
    }
    
    func testIfSampleDataIsLoadedCorrectly() throws {
        XCTAssert(coordinator.masterData?.data?.attributes?.commodities?.count == 4,"Commodity decoding error")
        XCTAssert(coordinator.masterData?.data?.attributes?.cryptocoins?.count == 30,"Commodity decoding error")
        XCTAssert(coordinator.masterData?.data?.attributes?.fiats?.count == 7,"Commodity decoding error")
        XCTAssert(coordinator.masterData?.data?.attributes?.wallets?.count == 37,"Commodity decoding error")
        XCTAssert(coordinator.masterData?.data?.attributes?.commodityWallets?.count == 11,"Commodity decoding error")
        XCTAssert(coordinator.masterData?.data?.attributes?.fiatWallets?.count == 4,"Commodity decoding error")
    }
    
    
    func testIfSampleDataPrecisionsAreDecoded() throws {
        if let cryptos = coordinator.masterData?.data?.attributes?.cryptocoins {
            cryptos.enumerated().forEach { (index,item) in
                XCTAssert(item?.attributes?.precisionForFiatPrice != nil,"cryptocoin \(index) fiat precision decoding error")
            }
        }
        
        if let cryptos = coordinator.masterData?.data?.attributes?.commodities {
            cryptos.enumerated().forEach { (index,item) in
                XCTAssert(item?.attributes?.precisionForFiatPrice != nil,"commodities \(index) fiat precision decoding error")
            }
        }
    }

}
