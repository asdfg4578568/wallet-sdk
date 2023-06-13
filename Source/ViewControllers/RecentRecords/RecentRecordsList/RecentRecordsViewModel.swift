//
//  RecentRecordsViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 15/12/2022.
//

import Foundation

struct RecentRecordModel {
    var imageName: String
    var title: String
    var amount: String
}

class RecentRecordsViewModel {
    
    var recentTransactions: RecentTransactions? {
        didSet {
            if let recentTransactions = recentTransactions {
                recentTransactionArray.append(contentsOf: recentTransactions.transactions)
                noMoreData = recentTransactions.transactions.count < pageSize
            }
        }
    }
    
    var recentTransactionArray: [RecentTransactionModel] = []
    var pageNumber: Int = 1
    var pageSize: Int = 20
    var noMoreData: Bool = false
    var isLoading: Bool = false
    var pullToRefresh: Bool = false

    var didFinishedloadMore: (Bool) -> Void = { _ in }
    
    func refreshData() {
        pageNumber = 1
        noMoreData = false
        isLoading = true
        pullToRefresh = true
        didFinishedloadMore(true)
    }
    
    func fetchRecentTransactions(completionHandler: @escaping (Bool) -> Void) {
        SDKManager.shared.getRecentTransactions(pageNumber: self.pageNumber,
                                          pageSize: self.pageSize) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let responseModel):
                if let responseModel = responseModel, responseModel.transactions.count != 0 {
                    if self.pullToRefresh {
                        self.pullToRefresh = false
                        self.recentTransactionArray = []
                    }
                    self.pageNumber += 1
                    self.recentTransactions = responseModel
                    print("transactions count....\(self.recentTransactionArray.count)")
                    completionHandler(true)
                } else if self.recentTransactionArray.count == 0 {
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
            fetchRecentTransactions { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case true: self.didFinishedloadMore(true)
                case false: break
                }
            }
        }
    }
}
