//
//  MnemonicPhrasesSelectedViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 22/12/2022.
//

import Foundation

class MnemonicPhrasesSelectedViewModel {
    
    var phrasesArray: [MnemonicPhrasesModel] = [] {
        didSet {
            didChanged(true)
        }
    }
    
    var didChanged: (Bool) -> Void = { _ in }

    init() {
        
    }
    
    func addPhrase(with model: MnemonicPhrasesModel) {
        phrasesArray.append(model)
    }
    
    func removePhrase(at index: Int) {
        phrasesArray.remove(at: index)
    }
}
