//
//  SDKAddressProtocol.swift
//  WalletSDK
//
//  Created by ashahrouj on 07/01/2023.
//

import Foundation
import WalletSdkCore

protocol SDKAddressProtocol {
    func addAddressBook(with coinType: Int, address: String, name: String, completionHandler: @escaping (Result<Bool>) -> Void)
}

extension SDKAddressProtocol {
    
    func addAddressBook(with coinType: Int, address: String, name: String, completionHandler: @escaping (Result<Bool>) -> Void) {
        //let data = WalletSdkCore.Cold_walletAddAddressBook(coinType, address, name)
        //completionHandler(.success(data))
    }
}
