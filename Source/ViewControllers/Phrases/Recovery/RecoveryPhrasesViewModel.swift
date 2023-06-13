//
//  RecoveryPhrasesViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 26/12/2022.
//

import Foundation

class RecoveryPhrasesViewModel {
    
    private(set) var phrasesFilterdArray: [MnemonicPhrasesModel] = []
    private(set) var phrasesSeclectedArray: [MnemonicPhrasesModel] = []

    var didWordFilterd: ([MnemonicPhrasesModel]) -> Void = {_ in }
    var didRecoveryFinihsed: (Bool) -> Void = {_ in }

    func filter(with phrase: String) {
        
        SDKManager.shared.fetchSeedPhrase(by: phrase) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let array = data.components(separatedBy: " ")
                let arrayOfPhrases = array.map({
                    return MnemonicPhrasesModel(phrase: $0, isSelected: false)
                })
                self.phrasesFilterdArray = arrayOfPhrases.filter{ $0.phrase.contains(phrase.lowercased()) }
                self.didWordFilterd(self.phrasesFilterdArray)

            case .failure(let error):
                print("something wrong when fetchSeedPhrase...\(error)")
                self.didWordFilterd([])
            }
        }
    }
    
    func remove(with phrase: MnemonicPhrasesModel) {
        phrasesSeclectedArray = phrasesSeclectedArray.filter{$0.phraseId != phrase.phraseId}
    }
    
    func add(with phrase: MnemonicPhrasesModel) {
        phrasesSeclectedArray.append(phrase)
    }
    
    func checkingRecoveryIfFinihsed() {
        if phrasesSeclectedArray.count == 12 {
            var array: [String] = []
            for (index, item) in phrasesSeclectedArray.enumerated() { // before was phrasesSeclectedArray.map({ return "\($0.phrase) "})
                if index != phrasesSeclectedArray.count - 1 { array.append("\(item.phrase) ") }
                else { array.append("\(item.phrase)") } // last one without extra space
            }
            let phrasesString = array.joined()
            
            SDKManager.shared.recoverUserAccount(for: phrasesString) { result in
                switch result {
                case .success(let data):
                    self.didRecoveryFinihsed(data)
                case .failure(let error):
                    self.didRecoveryFinihsed(false)
                    print("sometning wornge when recoverUserAccount \(error)")
                }
            }
        }
    }
    
    func phraseIsExist(with text: String) -> Bool {
        let phrasesFilterdArray = self.phrasesFilterdArray.filter{ $0.phrase == text.lowercased() }
        return phrasesFilterdArray.count == 1
    }
}
