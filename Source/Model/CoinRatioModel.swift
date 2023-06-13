//
//  CoinRatioModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 07/02/2023.
//

import Foundation

public typealias CoinRatios = [CoinRatioModel]

public struct CoinRatioModel: Codable {
    public let coinType: Int
    public let name: String
    public let usd, yuan, euro: Double
    // let usd, yuan, euro: CurrencyRatio //TODO: change to enum

    public enum CodingKeys: String, CodingKey {
        case coinType = "id"
        case name = "coin_type"
        case usd, yuan, euro
    }
}

public enum CurrencySymbol: Double {
    case usd
    case yuan
    case euro
    
    public var symbol: String {
        switch self {
        case .yuan: return "¥"
        case .usd: return "$"
        case .euro: return "€"
        }
    }
}
