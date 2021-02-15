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
    var showSectionHeader : Bool = true
    var showFloaty: Bool = true

    init(wallets: [WalletItem],commodityWallets: [WalletItem],fiatWallets:[FiatWalletItem],logoDic: [String:LogoItem],type: WalletType = .All,showFloaty: Bool = true,showSectionHeader: Bool = true){
        self.wallets = wallets
        self.commodityWallets = commodityWallets
        self.fiatWallets = fiatWallets
        self.logoDictionary = logoDic
        self.type = type
        self.showFloaty = showFloaty
        self.showSectionHeader = showSectionHeader
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
