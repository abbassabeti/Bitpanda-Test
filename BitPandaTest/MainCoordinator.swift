//
//  MainCoordinator.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import Foundation

class MainCoordinator {
    
    var masterData : MasterData?
    
    var logoDictionary : [String:LogoItem] = [:]
    
    init(){
        if let url = Bundle.main.url(forResource: "Masterdata", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MasterData.self, from: data)
                self.masterData = jsonData
                extractLogoAddresses()
            } catch let error{
                print("error:\(error)")
            }
        }
    }
    
    func provideAssetViewModel() -> AssetViewModel{
        return AssetViewModel(
            cryptocoins: self.masterData?.data?.attributes?.cryptocoins as? [AssetItem] ?? [],
            commodities: self.masterData?.data?.attributes?.commodities as? [AssetItem] ?? [],
            fiats: self.masterData?.data?.attributes?.fiats?.filter({$0?.attributes?.hasWallets ?? false}) as? [AssetItem] ?? [])
    }
    func provideWalletsViewModel() -> WalletViewModel{
        let wallets = (self.masterData?.data?.attributes?.wallets?.filter({$0?.attributes?.deleted == false}) as? [WalletItem] ?? []).sorted(by: { (a, b) -> Bool in
            return a.attributes?.balance ?? 0 >= b.attributes?.balance ?? 0
        })
        let commodityWallets = (self.masterData?.data?.attributes?.commodityWallets?.filter({$0?.attributes?.deleted == false}) as? [WalletItem] ?? []).sorted(by: { (a, b) -> Bool in
            return a.attributes?.balance ?? 0 >= b.attributes?.balance ?? 0
        })
        let fiatWallets = (self.masterData?.data?.attributes?.fiatWallets as? [FiatWalletItem] ?? []).sorted(by: { (a, b) -> Bool in
            return a.attributes?.balance ?? 0 >= b.attributes?.balance ?? 0
        })
        return WalletViewModel(wallets: wallets,
                               commodityWallets: commodityWallets,
                               fiatWallets: fiatWallets,
                               logoDic: logoDictionary)
    }
    
    //Wallets does not have any logo addresses in their models. So for showing icon on wallets, we need to extract them from Assets and save them in a dictionary with key of its Symbol
    func extractLogoAddresses(){
        if let cryptoCoins = self.masterData?.data?.attributes?.cryptocoins {
            for item in cryptoCoins {
                let logo = item?.attributes?.logo
                let darkLogo = item?.attributes?.logoDark
                guard let symbol = item?.attributes?.symbol else {return}
                guard let _ = logoDictionary[symbol] else {
                    logoDictionary[symbol] = LogoItem(logo: logo,darkLogo: darkLogo)
                    continue
                }
            }
        }
    }
    
    func provideAssetViewController () -> AssetViewController {
        let assetVC = AssetViewController()
        assetVC.viewModel = self.provideAssetViewModel()
        
        return assetVC
    }
    
    func provideWalletViewController () -> WalletsViewController {
        let walletVC = WalletsViewController()
        walletVC.viewModel = self.provideWalletsViewModel()
        
        return walletVC
    }
    
}
