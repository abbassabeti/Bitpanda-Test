//
//  Attributes.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import Foundation
struct Attributes: Codable {
    let symbol, name: String?
    let sort: Int?
    let assetTypeName: AssetType?
    let assetGroupName: AssetGroupName?
    let urlCheckAddress, urlCheckTransaction: String?
    let buyActive, sellActive, withdrawActive, depositActive: Bool?
    let transferActive, available, maintenanceEnabled: Bool?
    let minBuyEur, minSellEur, minWithdrawEur, defaultSellAmount: String?
    let precisionForFiatPrice, precisionForCoins, precisionForTx: Int?
    let walletMinDeposit, walletSmallDeposit, walletSmallDepositFee, avgPrice: String?
    let color, walletWithdrawFee, change24H, change24HAmount: String?
    let change1W, change1WAmount, change1M, change1MAmount: String?
    let change1Y, change1YAmount: String?
    let logo, logoDark: String?
    let supportDestinationTag: Bool?
    let circulatingSupply: String?
    let allowedUnverified, allowedDocumented, allowedVerified: Bool?
    let measurementUnit: String?
//    let ieoPhases: [String?]?
    let info, unavailableReason, maintenanceReason, walletInfo: String?
    let extraInfo, infoIntegration, infoDeu, infoEng: String?
    let infoFra, unavailableReasonDeu, unavailableReasonEng, unavailableReasonFra: String?
    let maintenanceReasonDeu, maintenanceReasonEng, maintenanceReasonFra, walletInfoDeu: String?
    let walletInfoEng, walletInfoFra, extraInfoDeu, extraInfoEng: String?
    let extraInfoFra, infoIntegrationDeu, infoIntegrationEng, infoIntegrationFra: String?
    let investmentInfo, investmentInfoDeu, investmentInfoEng, investmentInfoFra: String?
    let androidSupportedVersion: String?
    let iosSupportedVersion: String?
    let hasWallets : Bool?
    //let family: Family?

    enum CodingKeys: String, CodingKey {
        case symbol, name, sort
        case assetTypeName = "asset_type_name"
        case assetGroupName = "asset_group_name"
        case urlCheckAddress = "url_check_address"
        case urlCheckTransaction = "url_check_transaction"
        case buyActive = "buy_active"
        case sellActive = "sell_active"
        case withdrawActive = "withdraw_active"
        case depositActive = "deposit_active"
        case transferActive = "transfer_active"
        case available
        case maintenanceEnabled = "maintenance_enabled"
        case minBuyEur = "min_buy_eur"
        case minSellEur = "min_sell_eur"
        case minWithdrawEur = "min_withdraw_eur"
        case defaultSellAmount = "default_sell_amount"
        case precisionForFiatPrice = "precision_for_fiat_price"
        case precisionForCoins = "precision_for_coins"
        case precisionForTx = "precision_for_tx"
        case walletMinDeposit = "wallet_min_deposit"
        case walletSmallDeposit = "wallet_small_deposit"
        case walletSmallDepositFee = "wallet_small_deposit_fee"
        case avgPrice = "avg_price"
        case color
        case walletWithdrawFee = "wallet_withdraw_fee"
        case change24H = "change_24h"
        case change24HAmount = "change_24h_amount"
        case change1W = "change_1w"
        case change1WAmount = "change_1w_amount"
        case change1M = "change_1m"
        case change1MAmount = "change_1m_amount"
        case change1Y = "change_1y"
        case change1YAmount = "change_1y_amount"
        case logo
        case logoDark = "logo_dark"
        case supportDestinationTag = "support_destination_tag"
        case circulatingSupply = "circulating_supply"
        case allowedUnverified = "allowed_unverified"
        case allowedDocumented = "allowed_documented"
        case allowedVerified = "allowed_verified"
        case measurementUnit = "measurement_unit"
//        case ieoPhases = "ieo_phases"
        case info
        case unavailableReason = "unavailable_reason"
        case maintenanceReason = "maintenance_reason"
        case walletInfo = "wallet_info"
        case extraInfo = "extra_info"
        case infoIntegration = "info_integration"
        case infoDeu = "info_deu"
        case infoEng = "info_eng"
        case infoFra = "info_fra"
        case unavailableReasonDeu = "unavailable_reason_deu"
        case unavailableReasonEng = "unavailable_reason_eng"
        case unavailableReasonFra = "unavailable_reason_fra"
        case maintenanceReasonDeu = "maintenance_reason_deu"
        case maintenanceReasonEng = "maintenance_reason_eng"
        case maintenanceReasonFra = "maintenance_reason_fra"
        case walletInfoDeu = "wallet_info_deu"
        case walletInfoEng = "wallet_info_eng"
        case walletInfoFra = "wallet_info_fra"
        case extraInfoDeu = "extra_info_deu"
        case extraInfoEng = "extra_info_eng"
        case extraInfoFra = "extra_info_fra"
        case infoIntegrationDeu = "info_integration_deu"
        case infoIntegrationEng = "info_integration_eng"
        case infoIntegrationFra = "info_integration_fra"
        case investmentInfo = "investment_info"
        case investmentInfoDeu = "investment_info_deu"
        case investmentInfoEng = "investment_info_eng"
        case investmentInfoFra = "investment_info_fra"
        case androidSupportedVersion = "android_supported_version"
        case iosSupportedVersion = "ios_supported_version"
        case hasWallets = "has_wallets"
        //case family
    }
}

extension Attributes : Equatable {
    static func == (lhs: Attributes, rhs: Attributes) -> Bool {
        return lhs.symbol == rhs.symbol &&
            lhs.name == rhs.name &&
            lhs.hasWallets == rhs.hasWallets
    }
}
