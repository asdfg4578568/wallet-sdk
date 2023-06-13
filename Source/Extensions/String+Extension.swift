//
//  String+Extension.swift
//  CryptoWalletSDK
//
//  Created by ashahrouj on 27/02/2023.
//

import Foundation
import UIKit

public extension String {
    
    var imageByName: UIImage? {
        var podBundle = Bundle(for: SplashViewViewCell.classForCoder())
        if let bundleURL = podBundle.url(forResource: "CryptoWalletSDK", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                podBundle = bundle
            }
        }
        
        return UIImage(named: self, in: podBundle, with: nil)
    }
    
    var customLocalizedErrorMessage: String {
        if self.contains("3014") { return "3014".localized }
        else if self.contains("3015") { return "3015".localized }
        else if self.contains("3016") { return "3016".localized }
        else if self.contains("3005") { return "3005".localized }
        else if self.contains("3012") { return "3012".localized }
        else if self.contains("3017") { return "3017".localized }
        else if self.contains("3018") { return "3018".localized }
        else if self.contains("3100") { return "3100".localized }
        else if self.contains("3013") { return "3013".localized }
        else { return "something_wrong_try_again".localized }
    }
}
