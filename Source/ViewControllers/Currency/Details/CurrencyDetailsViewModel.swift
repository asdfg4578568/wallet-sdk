//
//  CurrencyDetailsViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 19/12/2022.
//

import Foundation

class CurrencyDetailsViewModel {
    
    var shouldDisplayBandwidth: Bool {
        return currencyModel.asset.name == CurrencyAssetsEnum.trx.name || currencyModel.asset.name == CurrencyAssetsEnum.usdtTrc20.name
    }
    
    private(set) var currencyModel: CurrencyModel
    init(with currencyModel: CurrencyModel) {
        self.currencyModel = currencyModel
    }
    
    func getBalance(completionHandler: @escaping (Bool) -> Void) {
        getPublicAddress(with: currencyModel.coinType) { [weak self] isSuccess in
            guard let self = self else { return }
            switch isSuccess {
            case true:
                SDKManager.shared.getBalance(with: self.currencyModel.coinType) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let data):
                        self.currencyModel.balance = Double(data) ?? 0
                        completionHandler(true)
                    case .failure(let error):
                        print("something wronge when get balance \(error)")
                        completionHandler(false)
                    }
                }
            case false:
                completionHandler(false)
            }
        }
    }
    
    func getPublicAddress(with coinId: Int, completionHandler: @escaping (Bool) -> Void) { //TODO: still no supported
        SDKManager.shared.getPublicAddress(with: coinId) { [weak self] result in
            switch result {
            case .success(let data):
                completionHandler(!data.isEmpty)
            case .failure(let error):
                print("something wronge when get public address \(error)")
                completionHandler(false)
            }
        }
    }
}
