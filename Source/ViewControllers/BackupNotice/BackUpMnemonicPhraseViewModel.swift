//
//  BackUpMnemonicPhraseViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 03/01/2023.
//

import Foundation


class BackUpMnemonicPhraseViewModel {
    var shouldHideBottomActions: Bool
    var mnemonicPhrasesViewModel: MnemonicPhrasesViewModel
    init(shouldHideBottomActions: Bool = false) {
        self.shouldHideBottomActions = shouldHideBottomActions
        self.mnemonicPhrasesViewModel = MnemonicPhrasesViewModel(with: .displayOnly(shouldGenerating: !shouldHideBottomActions))
    }
}
