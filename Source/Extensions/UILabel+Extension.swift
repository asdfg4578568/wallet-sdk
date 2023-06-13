//
//  UILabel+Extension.swift
//  WalletSDK
//
//  Created by ashahrouj on 23/12/2022.
//

import Foundation
import UIKit

extension UILabel {
    func textColorChange (fullText: String,
                          changeText: String,
                          color: UIColor = UIColor.wLightLightBlue,
                          font: UIFont =  UIFont.font(name: .bold, and: 20) ) {
        
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        attribute.addAttribute(NSAttributedString.Key.font, value: font , range: range)

        self.attributedText = attribute
    }
    
    func displayAppVersionAndBuild() {
        var appVersionAndBuild = "v"
        if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            appVersionAndBuild.append(appVersion)
        } else {
           print("your platform does not support this feature.")
        }
        if let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
           print("Build number: \(buildNumber)")
            appVersionAndBuild.append(buildNumber)
        } else {
           print("your platform does not support this feature.")
        }
        self.text = appVersionAndBuild
    }
}
