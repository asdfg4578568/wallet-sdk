//
//  CurrencyAssetsEnum.swift
//  WalletSDK
//
//  Created by ashahrouj on 20/12/2022.
//

import Foundation
import UIKit

public enum CurrencyAssetsEnum {
    case btc
    case eth
    case usdtErc20
    case trx
    case usdtTrc20
    case empty
    
    public static func getAssetsEnumType(by coinType: Int) -> CurrencyAssetsEnum {
        switch coinType {
        case 1: return .btc
        case 2: return .eth
        case 3: return .usdtErc20
        case 4: return .trx
        case 5: return .usdtTrc20
        default: return .btc
        }
    }
    
    public var name: String {
        switch self {
        case .btc: return "BTC"
        case .eth: return "ETH"
        case .usdtErc20: return "USDT-ERC20"
        case .trx: return "TRX"
        case .usdtTrc20: return "USDT-TRC20"
        case .empty: return ""
        }
    }
    
    public var coinId: Int {
        switch self {
        case .btc: return 1
        case .eth: return 2
        case .usdtErc20: return 3
        case .trx: return 4
        case .usdtTrc20: return 5
        case .empty: return 0
        }
    }
    
    public var iconName: String {
        switch self {
        case .btc: return "asset_usdt_btc_icon"
        case .eth: return "asset_usdt_eth_icon"
        case .usdtErc20: return "asset_usdt_erc20_icon"
        case .trx: return "asset_usdt_trx_icon"
        case .usdtTrc20: return "asset_usdt_trc20_icon"
        case .empty: return ""
        }
    }
    
    public var iconNameWithBorder: String {
        switch self {
        case .btc: return "asset_usdt_btc_with_border_icon"
        case .eth: return "asset_usdt_eth_with_border_icon"
        case .usdtErc20: return "asset_usdt_erc20_with_border_icon"
        case .trx: return "asset_usdt_trc_with_border_icon"
        case .usdtTrc20: return "asset_usdt_trc20_with_border_icon"
        case .empty: return ""
        }
    }
    
    public var homeIconBackgroundColor: UIColor {
        switch self {
        case .btc: return .wWDarkGold
        case .eth: return .wDarkPurpl
        case .usdtErc20: return .wDarkGreen1
        case .trx: return .wDarkRed
        case .usdtTrc20: return .wDarkGreen2
        case .empty: return .wWhite
        }
    }
    
    public var homeBackgroundColor: UIColor {
        switch self {
        case .btc: return .wWLightLightGold
        case .eth: return .wLightLightPurpl
        case .usdtErc20: return .wLightLightGreen1
        case .trx: return .wLightLightRed
        case .usdtTrc20: return .wLightLightGreen2
        case .empty: return .wWhite
        }
    }
    
    public var cardIconBackgroundColor: UIColor {
        switch self {
        case .btc: return .wWDarkGold
        case .eth: return .wLightPurpl
        case .usdtErc20: return .wDarkGreen1
        case .trx: return .wDarkRed
        case .usdtTrc20: return .wDarkGreen2
        case .empty: return .wWhite
        }
    }
    
    public var cardBackgroundColor: UIColor {
        switch self {
        case .btc: return .wGold_FFB
        case .eth: return .wPurpl
        case .usdtErc20: return .wGreen_5BC
        case .trx: return .wRed_FF6
        case .usdtTrc20: return .wGreen_07B
        case .empty: return .wWhite
        }
    }
    
    
    public var nameOnlyForTransfer: String {
        switch self {
        case .btc: return "BTC"
        case .eth, .usdtErc20: return "ETH"
        case .trx, .usdtTrc20: return "TRX"
        case .empty: return ""
        }
    }
    
}
