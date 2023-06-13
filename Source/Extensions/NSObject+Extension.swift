//
//  NSObject+Extension.swift
//  WalletSDK
//
//  Created by ashahrouj on 15/12/2022.
//

import Foundation
import Localize_Swift

extension NSObject {
    class var className: String {
        return String.init(describing: self)
    }
}

extension String {
    var containsNonEnglishNumbers: Bool {
        return !isEmpty && range(of: "[^0-9].[^0-9]", options: .regularExpression) == nil
    }
    
    var localized: String {
        var podBundle = Bundle(for: SplashViewViewCell.classForCoder())
        if let bundleURL = podBundle.url(forResource: "CryptoWalletSDK", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                podBundle = bundle
            }
        }
        return localized(using: nil, in: podBundle)
    }
}
