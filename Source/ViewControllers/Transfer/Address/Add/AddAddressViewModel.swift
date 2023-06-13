//
//  AddAddressViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 30/12/2022.
//

import Foundation

class AddAddressViewModel {
    
    enum TextFieldOrder: Int {
        case name = 1
        case address = 2
    }
    
    var title: String {
        switch currencyModel.asset {
        case .usdtTrc20, .trx: return String(format: "address_add_coin_x_address_title".localized, "TRX (USDT-TRC20)")
        case .eth, .usdtErc20: return String(format: "address_add_coin_x_address_title".localized, "ETH (USDT-ERC20)")
        case .btc: return String(format: "address_add_coin_x_address_title".localized, "BTC")
        default: return ""
        }
    }
    
    var name: String = ""
    var address: String = ""

    var enablSavePressed: (Bool) -> Void = { _ in }

    private(set) var currencyModel: CurrencyModel
    init(with currencyModel: CurrencyModel, and address: String = "") {
        self.currencyModel = currencyModel
        self.address = address
    }
    
    func addAddress(completionHandler: @escaping (Result<Bool>) -> Void) {
        SDKManager.shared.addAddressBook(with: currencyModel.coinType, address: address, name: name) { [weak self] isSuccess in
            guard let _ = self else { return }
            completionHandler(isSuccess)
        }
    }
    
    func update(with text: String, type: AddAddressViewModel.TextFieldOrder) {
        switch type {
        case .name: name = text
        case .address: address = text
        }
        enablSavePressed(name.count >= 1 && address.count >= 1)
    }
}
