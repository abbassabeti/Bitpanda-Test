//
//  MainCoordinator.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import UIKit

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
    
    func provideAssetViewModel(type: AssetType = .All,showFloaty: Bool = true,showSectionHeader: Bool = false) -> AssetViewModel{
        return AssetViewModel(
            cryptocoins: self.masterData?.data?.attributes?.cryptocoins as? [AssetItem] ?? [],
            commodities: self.masterData?.data?.attributes?.commodities as? [AssetItem] ?? [],
            fiats: self.masterData?.data?.attributes?.fiats?.filter({$0?.attributes?.hasWallets ?? false}) as? [AssetItem] ?? [],
            type: type,
            showSectionHeader: showSectionHeader,
            showFloaty: showFloaty)
    }
    func provideWalletsViewModel(type: WalletType = .All,showFloaty: Bool = true,showSectionHeader: Bool = false) -> WalletViewModel{
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
                               logoDic: logoDictionary,
                               type: type,
                               showFloaty: showFloaty,
                               showSectionHeader: showSectionHeader)
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
        
        if let commodities = self.masterData?.data?.attributes?.commodities {
            for item in commodities {
                let logo = item?.attributes?.logo
                let darkLogo = item?.attributes?.logoDark
                guard let symbol = item?.attributes?.symbol else {return}
                guard let _ = logoDictionary[symbol] else {
                    logoDictionary[symbol] = LogoItem(logo: logo,darkLogo: darkLogo)
                    continue
                }
            }
        }
        
        if let fiats = self.masterData?.data?.attributes?.fiats {
            for item in fiats {
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
    
    /// for showing all types with a badgedFilter on branch feature/FilterActionButton
    
    func provideAssetViewController () -> AssetViewController {
        let assetVC = AssetViewController()
        assetVC.viewModel = self.provideAssetViewModel(showSectionHeader: true)
        
        return assetVC
    }
    
    func provideWalletViewController () -> WalletsViewController {
        let walletVC = WalletsViewController()
        walletVC.viewModel = self.provideWalletsViewModel(showSectionHeader: true)
        
        return walletVC
    }
    
    
    /// for showing different Wallets and Assets in different PagerViewControllers on main branch
    
    func provideAssetViewControllerArray () -> [AssetViewController] {
        let cryptocoinVC = AssetViewController()
        let commodityVC = AssetViewController()
        let fiatVC = AssetViewController()
        
        cryptocoinVC.viewModel = self.provideAssetViewModel(type: .Cryptocoin, showFloaty: false, showSectionHeader: false)
        commodityVC.viewModel = self.provideAssetViewModel(type: .Commodity, showFloaty: false, showSectionHeader: false)
        fiatVC.viewModel = self.provideAssetViewModel(type: .Fiat, showFloaty: false, showSectionHeader: false)
        return [cryptocoinVC,commodityVC,fiatVC]
    }
    
    func provideWalletViewControllerArray () -> [WalletsViewController] {
        let walletVC = WalletsViewController()
        let commodityWalletVC = WalletsViewController()
        let fiatWalletVC = WalletsViewController()
        
        walletVC.viewModel = self.provideWalletsViewModel(type: .Wallet, showFloaty: false, showSectionHeader: false)
        commodityWalletVC.viewModel = self.provideWalletsViewModel(type: .CommodityWallet, showFloaty: false, showSectionHeader: false)
        fiatWalletVC.viewModel = self.provideWalletsViewModel(type: .FiatWallet, showFloaty: false, showSectionHeader: false)
        return [walletVC,commodityWalletVC,fiatWalletVC]
    }
    
    func provideAssetViewControllerNames() -> [String] {
        return [AssetType.Cryptocoin,AssetType.Commodity,AssetType.Fiat].map({$0.getTitleName()})
    }
    
    func provideWalletViewControllerNames() -> [String] {
        return [WalletType.Wallet,WalletType.CommodityWallet,WalletType.FiatWallet].map({$0.getTitleName()})
    }
    
    func provideOverallViewControllerNames() -> [String] {
        return [LocalizedString("asset_tab"),
                LocalizedString("wallet_tab")]
    }
    
    func provideAssetsTabViewController() -> TabsViewController {
        let assetVCItems = provideAssetViewControllerArray()
        let assetsVC = TabsViewController()
        assetsVC.setVCNames(names: provideAssetViewControllerNames())
        assetsVC.setViewControllers(vcs: assetVCItems)
        
        let imgSize = CGSize(width: 25, height: 25)
        let assetImg = UIImage(named: "coin-def")?.imageWith(newSize: imgSize)
        let assetFilledImg = UIImage(named: "coin-filled")?.imageWith(newSize: imgSize)
        let tabName = LocalizedString("asset_tab")
        assetsVC.tabBarItem = UITabBarItem(title: tabName, image: assetImg, selectedImage: assetFilledImg)
        
        return assetsVC
    }
    
    func provideWalletsTabViewController() -> TabsViewController {
        let walletVCItems = provideWalletViewControllerArray()
        let walletsVC = TabsViewController()
        walletsVC.setVCNames(names: provideWalletViewControllerNames())
        walletsVC.setViewControllers(vcs: walletVCItems)
        
        let imgSize = CGSize(width: 25, height: 25)
        let assetImg = UIImage(named: "wallet-def")?.imageWith(newSize: imgSize)
        let assetFilledImg = UIImage(named: "wallet-filled")?.imageWith(newSize: imgSize)
        let tabName = LocalizedString("wallet_tab")
        walletsVC.tabBarItem = UITabBarItem(title: tabName, image: assetImg, selectedImage: assetFilledImg)
        
        return walletsVC
    }
    
    func provideOverallTabViewController() -> TabsViewController {
        let overallVCItems = [provideAssetViewController(),provideWalletViewController()]
        let overallVC = TabsViewController()
        overallVC.setVCNames(names: provideOverallViewControllerNames())
        overallVC.setViewControllers(vcs: overallVCItems)
        
        let imgSize = CGSize(width: 25, height: 23)
        let bigImgSize = CGSize(width: 30,height: 27)
        let assetImg = UIImage(systemName: "circle.grid.2x2")?.imageWith(newSize: imgSize).image(alpha:0.5)
        let assetFilledImg = UIImage(systemName: "circle.grid.2x2.fill")?.imageWith(newSize: bigImgSize).image(alpha:0.5)
        let tabName = LocalizedString("overall_tab")
        overallVC.tabBarItem = UITabBarItem(title: tabName, image: assetImg, selectedImage: assetFilledImg)
        
        return overallVC
    }
    
    
    
}
