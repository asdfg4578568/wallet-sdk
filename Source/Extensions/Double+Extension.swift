//
//  Double+Extension.swift
//  WalletSDK
//
//  Created by ashahrouj on 11/02/2023.
//

import Foundation

public extension Double {
    
    var descriptionFor2Digits: String {
        //let double = Double(truncating: self as NSNumber)
        return "\(SDKManager.shared.currencySymbol.symbol)\(String(format: "%.2f", self))"
    }
    
    var descriptionFor12Digits: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 10
        formatter.minimumFractionDigits = 0

        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)"
    }
    
    var descriptionFor8Digits: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 8
        formatter.minimumFractionDigits = 0

        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)"
    }
    
    var descriptionFor6Digits: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 6
        formatter.minimumFractionDigits = 0

        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)"
    }
    
    func getDescriptionDigits(by coinType: CurrencyAssetsEnum) -> String {
        switch coinType {
        case .btc, .eth: return self.descriptionFor8Digits
        default: return self.descriptionFor6Digits
        }
    }
}
