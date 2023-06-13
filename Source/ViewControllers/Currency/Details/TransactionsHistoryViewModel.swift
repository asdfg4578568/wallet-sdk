//
//  TransactionsHistoryViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 14/01/2023.
//

import Foundation

class TransactionsHistoryViewModel {
    
    enum TransactionsHistoryType: Int {
        case all = 0
        case send
        case receive
    }
    
    let type: TransactionsHistoryType
    let coinType: Int
    var transactionsModel: TransactionsHistoryModel? {
        didSet {
            if let transactionsModel = transactionsModel {
                transactions.append(contentsOf: transactionsModel.transaction)
                noMoreData = transactionsModel.transaction.count < pageSize
            }
        }
    }
    
    var transactions: [TransactionHistoryModel] = []
    
    var pageNumber: Int = 1
    var pageSize: Int = 20
    var noMoreData: Bool = false
    var isLoading: Bool = false
    var pullToRefresh: Bool = false

    var didFinishedloadMore: (Bool) -> Void = { _ in }
    
    init(with type: TransactionsHistoryType, coinType: Int) {
        self.type = type
        self.coinType = coinType
    }
    
    func refreshData() {
        pageNumber = 1
        noMoreData = false
        isLoading = true
        pullToRefresh = true
        didFinishedloadMore(true)
    }
    
    func fetcTransactionList(completionHandler: @escaping (Bool) -> Void) {
        SDKManager.shared.transactionList(with: type.rawValue,
                                          coinType: self.coinType,
                                          pageNumber: self.pageNumber,
                                          pageSize: self.pageSize) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let responseModel):
                if let responseModel = responseModel, responseModel.transaction.count != 0 {
                    if self.pullToRefresh {
                        self.pullToRefresh = false
                        self.transactions = []
                    }
                    self.pageNumber += 1
                    self.transactionsModel = responseModel
                    print("transactions count....\(self.transactions.count)")
                    completionHandler(true)
                } else if self.transactions.count == 0 {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
                
            case .failure(let error):
                completionHandler(false)
                print("something wrong \(error) when fetch transactionList")
            }
        }
    }
    
    func loadMoreData() {
        print("page.......\(self.pageNumber)")
        if noMoreData { return }
        if !self.isLoading {
            self.isLoading = true
            fetcTransactionList { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case true: self.didFinishedloadMore(true)
                case false: break
                }
            }
        }
    }
    
    func getTransactionsItem(by index: Int) -> TransactionHistoryModel {
        let assetType = CurrencyAssetsEnum.getAssetsEnumType(by: coinType)
        var model = self.transactions[index]
        model.currencyAssetsType = assetType
        return model
    }
}
