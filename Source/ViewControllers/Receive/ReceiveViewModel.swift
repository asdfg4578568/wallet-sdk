//
//  ReceiveViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 30/12/2022.
//

import Foundation

class ReceiveViewModel {
    
    var title: String {
        switch currencyModel.asset {
        case .usdtTrc20, .trx:
            return "TRX (USDT-TRC20) \("receiving_address_with_coin".localized)"
        case .eth, .usdtErc20:
            return "ETH (USDT-ERC20) \("receiving_address_with_coin".localized)"
        case .btc:
            return "BTC \("receiving_address_with_coin".localized)"
        default: return ""
        }
    }
    
    private(set) var currencyModel: CurrencyModel
    private(set) var publicAddress: String = ""
    
    init(with currencyModel: CurrencyModel) {
        self.currencyModel = currencyModel
    }
    
    func getPublicAddress(with coinId: Int, completionHandler: @escaping (Bool) -> Void) { //TODO: still no supported
        SDKManager.shared.getPublicAddress(with: coinId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.publicAddress = data
                completionHandler(!data.isEmpty)
            case .failure(let error):
                print("something wronge when verify \(error)")
                completionHandler(false)
            }
        }
    }
}
