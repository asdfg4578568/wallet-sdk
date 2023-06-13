//
//  SetGasFeeViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 27/12/2022.
//

import Foundation

enum GasFeesPriorityType: CaseIterable {
    case fast
    case medium
    case slow
    
    var title: String {
        switch self {
        case .fast: return "transfer_fast_title".localized
        case .medium: return "transfer_medium_title".localized
        case .slow: return "transfer_slow_title".localized
        }
    }
    
    var iconName: String {
        switch self {
        case .fast: return "fast_gas_fees_icon"
        case .medium: return "medium_gas_fees_icon"
        case .slow: return "low_gas_fees_icon"
        }
    }
}

class GasFeesPriorityModel {
    var price: Double
    var type: GasFeesPriorityType
    var isSelected: Bool
    var asset: CurrencyAssetsEnum
    
    init(price: Double = 0, type: GasFeesPriorityType, isSelected: Bool, asset: CurrencyAssetsEnum) {
        self.isSelected = isSelected
        self.type = type
        self.price = price
        self.asset = asset
    }
}

class SetGasFeeViewModel {
        
    private(set) var transferViewModel: TransferViewModel
    
    init(with transferViewModel: TransferViewModel) {
        self.transferViewModel = transferViewModel
    }
}
