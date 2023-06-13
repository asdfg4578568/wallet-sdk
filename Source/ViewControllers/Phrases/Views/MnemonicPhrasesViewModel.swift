//
//  MnemonicPhrasesViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 22/12/2022.
//

import Foundation

class MnemonicPhrasesViewModel {
    
    /*
    var phrasesArray: [MnemonicPhrasesModel] = [MnemonicPhrasesModel(phrase: "Car", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Family", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Home", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Love", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Flower", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Ball", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Food", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Cow", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Cran", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Buss", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Ameed", isSelected: false),
                                                MnemonicPhrasesModel(phrase: "Mother", isSelected: false)]
    */
    var phrasesArray: [MnemonicPhrasesModel] = []
    
    var didGenerated: (Bool) -> Void = { _ in }

    let mnemonicPhrasesType: MnemonicPhrasesType
    init(with mnemonicPhrasesType: MnemonicPhrasesType) {
        self.mnemonicPhrasesType = mnemonicPhrasesType
        
        switch mnemonicPhrasesType {
        case .displayOnly(let shouldGenerating):
            if shouldGenerating { generateUserAccount() }
            else { getSeedPhrase() }
        case .clickable:
            self.phrasesArray = SDKManager.shared.generatedArray[randomPick: SDKManager.shared.generatedArray.count]
        case .removable:
            self.phrasesArray = SDKManager.shared.generatedArray
        }
    }
    
    
    func selected(with index: Int) {
        phrasesArray[index].isSelected = true
    }
    
    func unSelected(with model: MnemonicPhrasesModel) {
        let index: Int = phrasesArray.firstIndex(where: {$0.phrase.contains(model.phrase) }) ?? 0
        phrasesArray[index].isSelected = false
    }
    
    func getPhrase(by index: Int) -> MnemonicPhrasesModel {
        switch mnemonicPhrasesType {
        case .displayOnly(_):
            let current = "\(index + 1).\(phrasesArray[index].phrase)"
            return MnemonicPhrasesModel(phrase: current, isSelected: phrasesArray[index].isSelected)
        default:
            return phrasesArray[index]
        }
    }
    
    func generateUserAccount() {
        SDKManager.shared.generateUserAccount() {[weak self] data in
            guard let self = self else { return }
            switch data {
            case .success(let data):
                let array = data.components(separatedBy: " ")
                let arrayOfPhrases = array.map({
                    return MnemonicPhrasesModel(phrase: $0, isSelected: false)
                })
                self.phrasesArray = arrayOfPhrases
                SDKManager.shared.generatedArray = arrayOfPhrases
                self.didGenerated(true)
                print("success generateUserAccount...\(data)")
            case .failure(let error):
                self.didGenerated(false)
                print("error generateUserAccount...\(error)")
            }
        }
    }
    
    func getSeedPhrase() {
        SDKManager.shared.getSeedPhrase() {[weak self] data in
            guard let self = self else { return }
            switch data {
            case .success(let data):
                let array = data.components(separatedBy: " ")
                let arrayOfPhrases = array.map({
                    return MnemonicPhrasesModel(phrase: $0, isSelected: false)
                })
                self.phrasesArray = arrayOfPhrases
                SDKManager.shared.generatedArray = arrayOfPhrases
                self.didGenerated(true)
                print("success getSeedPhrase...\(data)")
            case .failure(let error):
                self.didGenerated(false)
                print("error getSeedPhrase...\(error)")
            }
        }
    }
}
