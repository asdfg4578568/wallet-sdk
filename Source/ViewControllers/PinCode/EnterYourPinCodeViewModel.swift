//
//  EnterYourPinCodeViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 02/01/2023.
//

import Foundation

class EnterYourPinCodeViewModel {
    
    init() {
        
    }
    
    func verifyPasscode(with password: String, completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            SDKManager.shared.verifyPasscode(for: password) { [weak self] result in
                guard let _ = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        completionHandler(data)
                    case .failure(let error):
                        print("something wronge when verify \(error)")
                        completionHandler(false)
                    }
                }
            }
        }
        
    }
}
