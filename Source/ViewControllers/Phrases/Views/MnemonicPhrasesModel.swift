//
//  MnemonicPhrasesModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 22/12/2022.
//

import Foundation

public enum MnemonicPhrasesType {
    case removable
    case clickable
    case displayOnly(shouldGenerating: Bool)
}

public struct MnemonicPhrasesModel: Equatable {
    public static func == (lhs: MnemonicPhrasesModel, rhs: MnemonicPhrasesModel) -> Bool {
        return lhs.phraseId == rhs.phraseId
    }
    
    public var phraseId: String = UUID().uuidString
    public var phrase: String = ""
    public var isSelected: Bool = false
     
    public init(phrase: String, isSelected: Bool) {
        self.phrase = phrase
        self.isSelected = isSelected
    }
}
