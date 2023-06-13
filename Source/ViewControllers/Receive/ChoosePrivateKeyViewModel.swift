//
//  ChoosePrivateKeyViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 07/01/2023.
//

import Foundation

class ChoosePrivateKeyViewModel {
    
    enum PrivateKeyType: Int {
        case hex = 1
        case compressed = 2
        case uncompressed = 3
    }
    
    private(set) var privateKeyType: PrivateKeyType = .hex
    private(set) var privateKeyString: String = ""
    
    func getPrivateKey(completionHandler: @escaping (Bool) -> Void) { //TODO: still no supported
        SDKManager.shared.getPrivateKey(with: privateKeyType.rawValue) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.privateKeyString = data
                completionHandler(!data.isEmpty)
            case .failure(let error):
                print("something wronge when verify \(error)")
                completionHandler(false)
            }
        }
    }
    
    func update(with type: Int) {
        privateKeyType = ChoosePrivateKeyViewModel.PrivateKeyType(rawValue: type) ?? .hex
    }
}
