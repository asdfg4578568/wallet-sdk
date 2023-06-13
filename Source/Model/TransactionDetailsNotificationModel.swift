//
//  TransactionDetailsNotificationModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 20/02/2023.
//

import Foundation

// MARK: - Welcome
public struct TransactionDetailsNotificationModel: Codable {
    public let coinType: Int
    public let publicAddress, transactionHash: String

    enum CodingKeys: String, CodingKey {
        case coinType = "coin_type"
        case publicAddress = "public_address"
        case transactionHash = "transaction_hash"
    }
}
