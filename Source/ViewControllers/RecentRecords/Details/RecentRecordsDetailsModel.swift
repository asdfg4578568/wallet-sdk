//
//  RecentRecordsDetailsModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 16/12/2022.
//

import Foundation

public class RecentRecordsDetailsViewModel {
    
    let transactionHash: String
    let currencyModel: CurrencyModel
    var transactionHistoryModel: TransactionHistoryModel?
    var status: TransactionsStatus
    var shouldHideTimeGasSection: Bool = false
    
    var tansactionBaseUrl: String {
        switch currencyModel.asset {
        case .eth, .usdtErc20: return "https://etherscan.io/tx/"
        case .btc: return "https://www.blockchain.com/btc/tx/"
        case .trx, .usdtTrc20: return "https://tronscan.io/#/transaction/"
        default: return "https://etherscan.io/tx/"
        }
    }
    public init(with currencyModel: CurrencyModel, and transactionHash: String, status: TransactionsStatus = .pending) {
        self.currencyModel = currencyModel
        self.transactionHash = transactionHash
        self.status = status
        self.update(status: status)
    }
    
    func fetchTransaction(completionHandler: @escaping (Bool) -> Void) {
        SDKManager.shared.getTransaction(by: transactionHash, and: currencyModel.coinType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseModel):
                self.transactionHistoryModel = responseModel
                let assetType = CurrencyAssetsEnum.getAssetsEnumType(by: self.currencyModel.coinType)
                self.transactionHistoryModel?.currencyAssetsType = assetType
                self.update(status: responseModel?.status)
                completionHandler(responseModel != nil)
            case .failure(let error):
                completionHandler(false)
                print("something wrong \(error) when fetch Transaction")
            }
        }
    }
    
    private func update(status: TransactionsStatus? = .pending) {
        self.status = status ?? .pending //TODO: maybe i can remove this, check it later 
        shouldHideTimeGasSection = status == .pending
    }
}

