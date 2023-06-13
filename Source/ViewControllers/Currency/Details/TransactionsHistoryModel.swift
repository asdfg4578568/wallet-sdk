//
//  TransactionsHistoryModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 21/12/2022.
//

import Foundation

// MARK: - DataClass
public class TransactionsHistoryModel: Codable {
    public let operationID: String
    public let transaction: [TransactionHistoryModel]
    public let tranNums, page, pageSize: Int

    public enum CodingKeys: String, CodingKey {
        case operationID, transaction
        case tranNums = "tran_nums"
        case page
        case pageSize = "page_size"
    }
}

public class TransactionAddressModel: Codable {
    public let name: String
    public let address: String
}

public class TransactionHistoryModel: Codable {
    
    public let transactionID: Int
    public let uuID: String
    public let currentTransactionType: Int
    public let senderAccount, receiverAccount: TransactionAddressModel?
    public let senderAddress, receiverAddress: String
    public let confirmTimeDouble: Double
    public let transactionHash: String
    public let sentTime: Int
    public let amount, fee: Double
    public let gasPriceConv: String?
    public let isSend: Bool
    public let gasUsed, gasLimit: Double?
    //let gasPrice: Int?
    public let confirmBlockNumber: String
    public let status: TransactionsStatus
    
    public var currencyAssetsType: CurrencyAssetsEnum?
    public var receiverAddressForDisplay: (title: String, hideBackgoundColor: Bool) {
        switch isSend {
        case true:
            guard let receiverAccount = receiverAccount else {
                return ("transaction_details_save_to_my_address".localized, false)
            }
            return (String(format: "transaction_details_name_title".localized, receiverAccount.name), true)
        case false: return ("transaction_details_myself_address_title".localized, true)
        }
    }
    
    public var senderAddressForDisplay: (title: String, hideBackgoundColor: Bool) {
        switch isSend {
        case true:
            return ("transaction_details_myself_address_title".localized, true)
        case false:
            guard let senderAccount = senderAccount else {
                return ("transaction_details_save_to_my_address".localized, false)
            }
            return (String(format: "transaction_details_name_title".localized, senderAccount.name), true)
        }
    }
    
    
    public var amountForDisplayInHistoryList: String {
        switch option {
        case .send:
            switch currencyAssetsType {
            case .usdtErc20, .usdtTrc20: return "\("-")\(amount.descriptionFor8Digits)"
            default: return "\("-")\((amount + fee).descriptionFor8Digits)"
            }
        case .receive: return "\("+")\(amount.descriptionFor8Digits)"
        default: return amount.descriptionFor8Digits
        }
    }
    
    public var option: TransactionsHistoryOptions {
        return isSend ? .send : .receive
    }

    public var confirmTime: String {
        let date = Date(timeIntervalSince1970: confirmTimeDouble)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        //dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        //dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    public enum CodingKeys: String, CodingKey {
        case transactionID, uuID
        case currentTransactionType = "current_transaction_type"
        case senderAccount = "sender_account"
        case senderAddress = "sender_address"
        case receiverAccount = "receiver_account"
        case receiverAddress = "receiver_address"
        case confirmTimeDouble = "confirm_time"
        case transactionHash = "transaction_hash"
        case sentTime = "sent_time"
        case status
        case amount = "amount_conv"
        case fee = "fee_conv"
        case gasPriceConv = "gas_price_conv"
        case isSend = "is_send"
        case gasUsed = "gas_used"
        case gasLimit = "gas_limit"
        //case gasPrice = "gas_price"
        case confirmBlockNumber = "confirm_block_number"
    }
}
