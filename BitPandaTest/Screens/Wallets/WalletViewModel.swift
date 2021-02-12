//
//  WalletViewModel.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import Foundation

class WalletViewModel {
    
    var wallets : [WalletItem]
    var commodityWallets : [WalletItem]
    var fiatWallets : [FiatWalletItem]
    var logoDictionary : [String:LogoItem]
    var type : WalletType

    init(wallets: [WalletItem],commodityWallets: [WalletItem],fiatWallets:[FiatWalletItem],logoDic: [String:LogoItem]){
        self.wallets = wallets
        self.commodityWallets = commodityWallets
        self.fiatWallets = fiatWallets
        self.logoDictionary = logoDic
        self.type = .All
    }
    
    func getCorrespondingGroup(type: WalletType? = nil) -> [Any]{
        switch type ?? self.type {
            case .Wallet:
                return wallets
            case .CommodityWallet:
                return commodityWallets
            case .FiatWallet:
                return fiatWallets
            default:
                return []
        }
    }
    
    func getLogo(symbol: String) -> LogoItem? {
        return logoDictionary[symbol] ?? nil
    }
}
