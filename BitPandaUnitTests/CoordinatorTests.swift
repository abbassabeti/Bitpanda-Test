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
    var assetViewModel : AssetViewModel!
    var walletViewModel : WalletViewModel!
    
    override func setUpWithError() throws {
        coordinator = MainCoordinator()
        assetViewModel = coordinator.provideAssetViewModel()
        walletViewModel = coordinator.provideWalletsViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        coordinator = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIfCommodityCountIsRight() throws {
        XCTAssert(assetViewModel.commodities.count == coordinator.masterData?.data?.attributes?.commodities?.count,"Commodities in AssetViewModel error")
    }
    
    func testIfCryptocoinCountIsRight() throws {
        XCTAssert(assetViewModel.cryptoCoins.count == coordinator.masterData?.data?.attributes?.cryptocoins?.count,"Commodities in AssetViewModel error")
    }
    
    func testIfFiatsHaveWallet() throws{
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
    
    func testIfWalletsAreDeletedCorrectly() throws{
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
    }
    
    func testIfWalletsAreSorted() throws {
        walletViewModel.wallets.enumerated().forEach { (index,item) in
            if (index > 0){
                XCTAssert(walletViewModel.wallets[index - 1].attributes?.balance ?? 0 >= item.attributes?.balance ?? 0,"There is a problem with sort of wallets")
            }
        }
    }
    
    func testIfCommodityWalletsAreDeletedCorrectly() throws {
        if let allCommodityWallets = coordinator.masterData?.data?.attributes?.commodityWallets {
            allCommodityWallets.enumerated().forEach { (index,item) in
                if (walletViewModel.commodityWallets.contains(where: {$0 == item})){
                    XCTAssert(item?.attributes?.deleted == false,"There is a deleted wallet in list")
                }else{
                    XCTAssert(item?.attributes?.deleted == true,"We missed a not deleted wallet")
                }
            }
        }
    }
    
    func testIfCommodityWalletsAreSorted() throws {
        walletViewModel.commodityWallets.enumerated().forEach { (index,item) in
            if (index > 0){
                XCTAssert(walletViewModel.commodityWallets[index - 1].attributes?.balance ?? 0 >= item.attributes?.balance ?? 0,"There is a problem with sort of commodity wallets")
            }
        }
    }
    
    func testIfFiatWalletsAreSorted() throws {
        let allFiatWallets = walletViewModel.fiatWallets
        allFiatWallets.enumerated().forEach { (index,item) in
            if (index > 0){
                XCTAssert(allFiatWallets[index - 1].attributes?.balance ?? 0 >= item.attributes?.balance ?? 0,"There is a problem with sort of fiat wallets")
            }
        }
    }
    
    
}
