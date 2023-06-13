//
//  UIFont+Extension.swift
//  WalletSDK
//
//  Created by ashahrouj on 09/12/2022.
//

import Foundation
import UIKit

extension UIFont {
    
    public enum CutomFont: String, CaseIterable {
        case regular = "TitilliumWeb-Regular"
        case italic = "TitilliumWeb-Italic"
        case extraLight = "TitilliumWeb-ExtraLight"
        case extraLightItalic = "TitilliumWeb-ExtraLightItalic"
        case light = "TitilliumWeb-Light"
        case lightItalic = "TitilliumWeb-LightItalic"
        case semiBold = "TitilliumWeb-SemiBold"
        case semiBoldItalic = "TitilliumWeb-SemiBoldItalic"
        case bold = "TitilliumWeb-Bold"
        case boldItalic = "TitilliumWeb-BoldItalic"
        case black = "TitilliumWeb-Black"
    }
    
    @discardableResult
    class func font(name: CutomFont, and size: CGFloat) -> UIFont {
        return UIFont(name: name.rawValue, size: size) ?? UIFont.preferredFont(forTextStyle: .headline)
    }
    
    // When you have the font in a framework (not application), then you need to handle differently because of bundle.
    // Lazy var instead of method so it's only ever called once per app session.
    public static var loadFonts: () -> Void = {
        for fontName in CutomFont.allCases {
            loadFont(withName: fontName.rawValue)
        }
        return {}
    }()
    
    private static func loadFont(withName fontName: String) {
        var podBundle = Bundle(for: SplashViewViewCell.classForCoder())
        guard
            let bundleURL = podBundle.url(forResource: "CryptoWalletSDK", withExtension: "bundle"),
            let bundle = Bundle(url: bundleURL),
            let fontURL = bundle.url(forResource: fontName, withExtension: "ttf"),
            let fontData = try? Data(contentsOf: fontURL) as CFData,
            let provider = CGDataProvider(data: fontData),
            let font = CGFont(provider) else {
            return
        }
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
}
