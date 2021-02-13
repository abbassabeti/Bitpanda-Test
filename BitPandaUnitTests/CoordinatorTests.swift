//
//  FilterTests.swift
//  BitPandaUnitTests
//
//  Created by Abbas on 2/14/21.
//

import XCTest
@testable import BitPandaTest

class CoordinatorTests: XCTestCase {
    var coordinator : MainCoordinator!
    override func setUpWithError() throws {
        coordinator = MainCoordinator()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        coordinator = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIfAssetViewModelIsOk() throws{
        let assetViewModel = coordinator.provideAssetViewModel()
        XCTAssert(assetViewModel.commodities.count == coordinator.masterData?.data?.attributes?.commodities?.count,"Commodities in AssetViewModel error")
        XCTAssert(assetViewModel.cryptoCoins.count == coordinator.masterData?.data?.attributes?.cryptocoins?.count,"Commodities in AssetViewModel error")
        
        if let allFiats = coordinator.masterData?.data?.attributes?.fiats {
            for item in allFiats {
                if (assetViewModel.fiats.contains(where: {$0 == item})){
                    XCTAssert(item?.attributes?.hasWallets == true,"There is a fiat with no wallets in list")
                }else{
                    XCTAssert(item?.attributes?.hasWallets == false,"We missed a fiat with wallet")
                }
            }
        }
    }
    
    func testIfWalletViewModelIsOk() throws{
        let walletViewModel = coordinator.provideWalletsViewModel()
        
        if let allWallets = coordinator.masterData?.data?.attributes?.wallets {
            allWallets.enumerated().forEach { (index,item) in
                if (walletViewModel.wallets.contains(where: {$0 == item})){
                    XCTAssert(item?.attributes?.deleted == false,"There is a deleted wallet in list")
                }else{
                    XCTAssert(item?.attributes?.deleted == true,"We missed a not deleted wallet")
                }
            }
        }
        
        walletViewModel.wallets.enumerated().forEach { (index,item) in
            if (index > 0){
                XCTAssert(walletViewModel.wallets[index - 1].attributes?.balance ?? 0 >= item.attributes?.balance ?? 0,"There is a problem with sort of wallets")
            }
        }
        
        if let allCommodityWallets = coordinator.masterData?.data?.attributes?.commodityWallets {
            allCommodityWallets.enumerated().forEach { (index,item) in
                if (walletViewModel.commodityWallets.contains(where: {$0 == item})){
                    XCTAssert(item?.attributes?.deleted == false,"There is a deleted wallet in list")
                }else{
                    XCTAssert(item?.attributes?.deleted == true,"We missed a not deleted wallet")
                }
            }
        }
        
        walletViewModel.commodityWallets.enumerated().forEach { (index,item) in
            if (index > 0){
                XCTAssert(walletViewModel.commodityWallets[index - 1].attributes?.balance ?? 0 >= item.attributes?.balance ?? 0,"There is a problem with sort of commodity wallets")
            }
        }
        
        let allFiatWallets = walletViewModel.fiatWallets
        allFiatWallets.enumerated().forEach { (index,item) in
            if (index > 0){
                XCTAssert(allFiatWallets[index - 1].attributes?.balance ?? 0 >= item.attributes?.balance ?? 0,"There is a problem with sort of fiat wallets")
            }
        }
    }
}
