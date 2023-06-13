//
//  RecentTransactionsModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 10/02/2023.
//

import Foundation

public enum RecentTransactionType: String, Codable {
    case received
    case transfer
    
    var title: String {
        switch self {
        case .received: return "recent_records_success_received".localized
        case .transfer: return "recent_records_sent_failed".localized
        }
    }
}

public enum RecentTransactionState: String, Codable { //TODO: that should be the same 'TransactionsStatus', needs to refactoring
    case success
    case failed
    
    var title: String {
        switch self {
        case .success: return "recent_records_sent".localized
        case .failed: return "recent_records_sent_failed".localized
        }
    }
}


public struct RecentTransactions: Codable {
    public let transactions: [RecentTransactionModel]
    public let totalNum, page, pageSize: Int

    public enum CodingKeys: String, CodingKey {
        case transactions = "funds_log"
        case totalNum = "total_num"
        case page
        case pageSize = "page_size"
    }
}

// MARK: - FundsLog
public struct RecentTransactionModel: Codable {
    public let id: Int
    public let txid: String
    public let uid: Int
    public let transactionType: RecentTransactionType
    public let merchantUid, userAddress, userAddressName: String
    public let oppositeAddress, oppositeAddressName, coinType: String
    public let amountOfCoins, usdAmount, yuanAmount, euroAmount: Double
    public let networkFee, usdNetworkFee, yuanNetworkFee, euroNetworkFee: Double
    public let totalCoinsTransfered, totalUsdTransfered, totalYuanTransfered, totalEuroTransfered: Double
    public let creationTime: Double
    public let state: RecentTransactionState
    public let confirmationTime, gasLimit, gasPrice, gasUsed: Int
    public let confirmBlockNumber: Int

    public var asset: CurrencyAssetsEnum {
        if coinType.contains(CurrencyAssetsEnum.btc.name) {
            return .btc
        } else if coinType.contains(CurrencyAssetsEnum.eth.name) {
            return .eth
        } else if coinType.contains(CurrencyAssetsEnum.usdtErc20.name) {
            return .usdtErc20
        } else if coinType.contains(CurrencyAssetsEnum.trx.name) {
            return .trx
        } else if coinType.contains(CurrencyAssetsEnum.usdtTrc20.name) {
            return .usdtTrc20
        }
        return .empty
    }
    
    public var titleForDisplay: String {
        switch transactionType {
        case .received:
            switch state {
            case .success: return "recent_records_success_received".localized + " " + " \(amountOfCoins.descriptionFor8Digits)" + coinType
            case .failed: return "recent_records_failed_received".localized + " " + " \(amountOfCoins.descriptionFor8Digits)" + coinType
            }
        case .transfer:
            switch asset {
            case .usdtErc20, .usdtTrc20: return state.title + " \(amountOfCoins.descriptionFor8Digits) " + coinType
            default: return state.title + " \((amountOfCoins + networkFee).descriptionFor8Digits) " + coinType
            }
        }
    }
    
    var titleForDisplayInList: String {
        switch transactionType {
        case .received:
            switch state {
            case .success: return "recent_records_success_received".localized + " " + coinType
            case .failed: return  "recent_records_failed_received".localized + " " + coinType
            }
        case .transfer:
            switch state {
            case .success: return "recent_records_sent".localized + " " + coinType
            case .failed: return  "recent_records_sent_failed".localized + " " + coinType
            }
            
//            switch asset {
//            case .usdtErc20, .usdtTrc20: return state.title + " " + coinType
//            default: return state.title + " " + coinType
//            }
        }
    }
    
    public var amountForDisplayInList: String {
        switch transactionType {
        case .received: return "+\(amountOfCoins.descriptionFor8Digits)"
        case .transfer:
            switch asset {
            case .usdtErc20, .usdtTrc20: return "-\(amountOfCoins.descriptionFor8Digits)"
            default: return "-\((amountOfCoins + networkFee).descriptionFor8Digits)"
            }
        }
    }
    
    public var iconForDisplayInList: String {
        switch transactionType {
        case .received:
            switch state {
            case .success: return "success_received_icon"
            case .failed: return "failed_revecied_icon"
            }
        case .transfer:
            switch state {
            case .success: return "success_transfer_icon"
            case .failed: return "failed_revecied_icon"
            }
        }
    }
    
    public var titleForDisplayCreationTime: String {
        let date = Date(timeIntervalSince1970: creationTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm"
        //dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        //dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    public enum CodingKeys: String, CodingKey {
        case id, txid, uid
        case merchantUid = "merchant_uid"
        case transactionType = "transaction_type"
        case userAddress = "user_address"
        case userAddressName = "user_address_name"
        case oppositeAddress = "opposite_address"
        case oppositeAddressName = "opposite_address_name"
        case coinType = "coin_type"
        case amountOfCoins = "amount_of_coins"
        case usdAmount = "usd_amount"
        case yuanAmount = "yuan_amount"
        case euroAmount = "euro_amount"
        case networkFee = "network_fee"
        case usdNetworkFee = "usd_network_fee"
        case yuanNetworkFee = "yuan_network_fee"
        case euroNetworkFee = "euro_network_fee"
        case totalCoinsTransfered = "total_coins_transfered"
        case totalUsdTransfered = "total_usd_transfered"
        case totalYuanTransfered = "total_yuan_transfered"
        case totalEuroTransfered = "total_euro_transfered"
        case creationTime = "creation_time"
        case state
        case confirmationTime = "confirmation_time"
        case gasLimit = "gas_limit"
        case gasPrice = "gas_price"
        case gasUsed = "gas_used"
        case confirmBlockNumber = "confirm_block_number"
    }
}
