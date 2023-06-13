//
//  PublicAddressModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 02/02/2023.
//

import Foundation

//typealias publicAddressReponse = [PublicAddressModel]

public struct PublicAddressModel: Codable {
    public let name: String
    public let coinType: Int
    public let address, contractAddress: String

    enum CodingKeys: String, CodingKey {
        case name
        case coinType = "coin_type"
        case address
        case contractAddress = "contract_address"
    }
}

