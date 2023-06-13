//
//  ConfigurationModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 04/01/2023.
//

import Foundation

public enum WalletEnvironment {
    case dev
    case test
    case prod
    
    public var path: String {
        switch self {
        case .dev: return "http://devwalletapi.ddns.net:81"
        case .test: return "https://api.sharewallet-test.com"
        case .prod: return "https://api.sharewallets.io"
        }
    }
}

public struct ConfigurationModel: Codable {
    var platform: Int = 2
    var apiAddr: String = WalletEnvironment.test.path
    var dataDir: String = LocalFileManager.shared.getPath(for: .walletSdk)
    var logLevel: Int = 1
    
    enum CodingKeys: String, CodingKey {
        case platform = "platform"
        case apiAddr = "api_addr"
        case dataDir = "data_dir"
        case logLevel = "log_level"
    }
    
    public init(with environment: WalletEnvironment = .test) {
        apiAddr = environment.path
    }
}
