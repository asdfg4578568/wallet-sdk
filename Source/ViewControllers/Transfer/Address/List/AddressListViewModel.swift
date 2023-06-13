//
//  AddressListViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 30/12/2022.
//

import Foundation

class AddressListViewModel {
    
    var title: String {
        switch currencyModel.asset {
        case .usdtTrc20, .trx: return String(format: "address_book_of_coin_x_title".localized, "TRX(USDT-TRC20)")
        case .eth, .usdtErc20: return String(format: "address_book_of_coin_x_title".localized, "ETH(USDT-ERC20")
        case .btc: return String(format: "address_book_of_coin_x_title".localized, "BTC")
        default: return ""
        }
    }
    private(set) var addresses: [AddressModel] = []
    private(set) var currencyModel: CurrencyModel
    init(with currencyModel: CurrencyModel) {
        self.currencyModel = currencyModel
    }
    
    func getAddresses(completionHandler: @escaping (Bool) -> Void) {
        SDKManager.shared.getAddressesBook(with: currencyModel.coinType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let addresses):
                self.addresses = addresses
                completionHandler(true)
            case .failure(let error):
                print("Something wrong when getAddresses \(error)")
                completionHandler(false)
            }
        }
    }
    
    func deleteAddressBook(with address: String, completionHandler: @escaping (Bool) -> Void) {
        SDKManager.shared.deleteAddressBook(with: currencyModel.coinType, address: address) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let isSuccess):
                if isSuccess {
                    self.addresses = self.addresses.filter{ $0.address != address }
                }
                completionHandler(isSuccess)
            case .failure(let error):
                print("Something wrong when getAddresses \(error)")
                completionHandler(false)
            }
        }
    }
}
