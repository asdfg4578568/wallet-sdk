//
//  ConfirmPhrasesViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 05/01/2023.
//

import Foundation

class ConfirmPhrasesViewModel {
    
    let mnemonicPhrasesViewModel = MnemonicPhrasesViewModel(with: .clickable)
    let mnemonicPhrasesSelectedViewModel = MnemonicPhrasesSelectedViewModel()
    
    var didConfirmed: (Bool) -> Void = { _ in }
    
    init () {
        
        mnemonicPhrasesSelectedViewModel.didChanged = {[weak self] changed in
            guard let self = self else { return }
            self.didConfirmed(SDKManager.shared.generatedArray == self.mnemonicPhrasesSelectedViewModel.phrasesArray)
        }
    }
}
