//
//  CurrencyViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 06/12/2022.
//

import Foundation

public class CurrencyViewModel {
    
    var shouldHideData: Bool = false
    var currencies: [CurrencyModel] = []
    var baseUrlForBuy: String = "https://www.moonpay.com/buy"
    var shouldDisplaySpinner: Bool = true
    var shouldHideRecentTransaction: Bool = true
    var didFinishFetchData: (Bool) -> Void = {_ in } // all data except 'GetRecentTransactions'
    var didFinishFetchLocal: (Bool) -> Void = {_ in }
    var totalRatioBalance: Double = 0
    var totalRatioBalanceForDisplay: String { return totalRatioBalance.descriptionFor2Digits }
    var recentTransactionModel: RecentTransactionModel?

    public init() {
        
    }
    
    func fetchLocalCoins() {
        self.currencies = []
        DispatchQueue.global().async {
            SDKManager.shared.fetchLocalCoins() { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.currencies = data
                    self.fetchAllBalanceData()
                    
                    DispatchQueue.main.async {
                        self.didFinishFetchLocal(true)
                    }
                case .failure(let error):
                    print("something wronge when fetch local coins \(error)")
                }
            }
        }
    }
    
    func updateCoinStatuses() {
        SDKManager.shared.updateCoinStatuses()
    }
    
    func fetchAllBalanceData() {
        DispatchQueue.global().async {
            SDKManager.shared.getCoinRatio { ratiosResult in
                switch ratiosResult {
                case .success(let ratios):
                    self.getAllPublicAddresses(with: ratios)
                   
                case .failure(let error):
                    print("something wronge when fetch coinsRatio \(error)")
                    self.getAllPublicAddresses(with: nil)
                }
            }
        }
    }
    
    private func getAllPublicAddresses(with ratios: CoinRatios?) {
        SDKManager.shared.getAllPublicAddresses { publicAddressResult in
            switch publicAddressResult {
            case .success(let publicAddresses):
                
                self.totalRatioBalance = 0
                let group = DispatchGroup()
                for publicAddresse in publicAddresses {
                    group.enter()
                    let currencyModel = self.currencies.first(where: { $0.coinType == publicAddresse.coinType })
                    currencyModel?.publicAddress = publicAddresse
                    
                    currencyModel?.ratio = ratios?.first(where: { ratioModel in
                        ratioModel.coinType == currencyModel?.coinType
                    })
                    
                    SDKManager.shared.getBalance(with: currencyModel?.coinType ?? 1, publicAddress: publicAddresse.address) { balanceResult in
                        switch balanceResult {
                        case .success(let balance):
                            currencyModel?.balance = Double(balance) ?? 0
                        case .failure(let error):
                            currencyModel?.balance = 0
                            print("something wronge when fetch balance \(error)")
                        }
                        self.totalRatioBalance += currencyModel?.ratioBalance ?? 0
                        group.leave()
                    }
                }
                
                self.getRecentTransactions(with: group)
                
                group.notify(queue: DispatchQueue.main) {
                    self.didFinishFetchData(true)
                }
                
            case .failure(let error):
                print("something wronge when fetch publicAddresses \(error)")
            }
        }
    }
    
    func getRecentTransactions(with group: DispatchGroup) {
        group.enter()
        DispatchQueue.global(qos: .background).async {
            SDKManager.shared.getRecentTransactions(pageSize: 1) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.recentTransactionModel = data?.transactions.first
                        self.shouldHideRecentTransaction = data?.transactions.count == 0
                    case .failure(let error):
                        print("error \(error)")
                    }
                    group.leave()
                }
            }
        }
    }
}
