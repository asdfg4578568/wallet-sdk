//
//  UIColor+Extension.swift
//  WalletSDK
//
//  Created by ashahrouj on 06/12/2022.
//

import UIKit

extension UIColor {
    
    static var bundle: Bundle? {
        var podBundle = Bundle(for: SplashViewViewCell.classForCoder())
        if let bundleURL = podBundle.url(forResource: "CryptoWalletSDK", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                    podBundle = bundle
                
            }
        }
        return podBundle
    }
    
    // Blue
    static let wBlueE6F: UIColor = UIColor(named: "blue_E6_E6F9FF", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlueEB: UIColor = UIColor(named: "blue_EB_EBF1FE", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlueE6E: UIColor = UIColor(named: "blue_E6EDF7", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlue3A8: UIColor = UIColor(named: "blue_3A88FD", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlue1AB: UIColor = UIColor(named: "blue_1AB8D7", in: bundle, compatibleWith: .current) ?? .blue

    static let wGrayC2C: UIColor = UIColor(named: "gray_C2C0C0", in: bundle, compatibleWith: .current) ?? .blue
    static let wGray646: UIColor = UIColor(named: "gray_646464", in: bundle, compatibleWith: .current) ?? .blue

    
    static let wLightLightBlue: UIColor = UIColor(named: "light_light_blue_00CDFF", in: bundle, compatibleWith: .current) ?? .blue
    static let wLightLightSkyBlue: UIColor = UIColor(named: "light_light_sky_blue_B8E3F0", in: bundle, compatibleWith: .current) ?? .blue
    static let wLightBlue: UIColor = UIColor(named: "light_blue_E5F9FF", in: bundle, compatibleWith: .current) ?? .blue
    static let wLightSkyBlue: UIColor = UIColor(named: "light_sky_blue_A0DDF0", in: bundle, compatibleWith: .current) ?? .blue
    static let wMidLightBlue: UIColor = UIColor(named: "mid_light_blue_A8EBFF", in: bundle, compatibleWith: .current) ?? .blue
    static let wSkyBlue: UIColor = UIColor(named: "sky_blue_57C4E5", in: bundle, compatibleWith: .current) ?? .blue
    static let wSkyDarkBlue: UIColor = UIColor(named: "sky_dark_blue_0BA5D3", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlue: UIColor = UIColor(named: "blue_78D2F4", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlue_2A6: UIColor = UIColor(named: "blue_2A6ED4", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlue_E4F: UIColor = UIColor(named: "blue_E4FFF8", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlue_49B: UIColor = UIColor(named: "blue_49BEE2", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlue_39B: UIColor = UIColor(named: "blue_39B8DE", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlue_2BC: UIColor = UIColor(named: "blue_2BC8F2", in: bundle, compatibleWith: .current) ?? .blue

    // Gold
    static let wWLightLightGold: UIColor = UIColor(named: "light_light_gold_FFF9E5", in: bundle, compatibleWith: .current)  ?? .lightGray
    static let wWDarkGold: UIColor = UIColor(named: "dark_gold_F7931A", in: bundle, compatibleWith: .current) ?? .lightGray
    
    static let wGold_FFB: UIColor = UIColor(named: "gold_FFB65F", in: bundle, compatibleWith: .current)  ?? .lightGray
    static let wGreen_07B: UIColor = UIColor(named: "green_07BE8DF", in: bundle, compatibleWith: .current) ?? .lightGray
    static let wGreen_5BC: UIColor = UIColor(named: "green_5BC3A7", in: bundle, compatibleWith: .current) ?? .lightGray
    static let wRed_FF6: UIColor = UIColor(named: "red_FF665B", in: bundle, compatibleWith: .current) ?? .lightGray
    static let wblack_101: UIColor = UIColor(named: "black_101010", in: bundle, compatibleWith: .current)  ?? .lightGray
    static let wBlue_EAE: UIColor = UIColor(named: "blue_EAEFFB", in: bundle, compatibleWith: .current) ?? .blue
    static let wBlue_DFF: UIColor = UIColor(named: "blue_DFF5FF", in: bundle, compatibleWith: .current)  ?? .blue

    
    // Purpl
    static let wLightLightPurpl: UIColor = UIColor(named: "light_light_purpl_C2CFFF", in: bundle, compatibleWith: .current) ?? .white
    static let wLightPurpl: UIColor = UIColor(named: "light_purpl_627EEA", in: bundle, compatibleWith: .current) ?? .purple
    static let wPurpl: UIColor = UIColor(named: "purpl_4C6BE3", in: bundle, compatibleWith: .current) ?? .purple
    static let wDarkPurpl: UIColor = UIColor(named: "dark_purpl_3C5EE0", in: bundle, compatibleWith: .current) ?? .purple

    // Gray
    static let wWLightLightGray: UIColor = UIColor(named: "light_light_gray_F3F3F3", in: bundle, compatibleWith: .current)  ?? .lightGray
    static let wWLightGray: UIColor = UIColor(named: "light_gray_F5F5F5", in: bundle, compatibleWith: .current) ?? .lightGray
    static let wMidLightGray: UIColor = UIColor(named: "mid_light_gray_E9E9E9", in: bundle, compatibleWith: .current) ?? .gray
    static let wMidDarkGray: UIColor = UIColor(named: "mid_dark_gray_4A4A4A", in: bundle, compatibleWith: .current) ?? .gray
    static let wWLightDarkGray: UIColor = UIColor(named: "light_gray_dark_747474", in: bundle, compatibleWith: .current)  ?? .lightGray
    static let wGray: UIColor = UIColor(named: "gray_EEEEEE", in: bundle, compatibleWith: .current)  ?? .lightGray
    static let wDarkGray: UIColor = UIColor(named: "dark_gray_626262", in: bundle, compatibleWith: .current)  ?? .darkGray
    static let wGray8: UIColor = UIColor(named: "gray_8_F5F7FF", in: bundle, compatibleWith: .current) ?? .darkGray
    static let wGrayF7F: UIColor = UIColor(named: "gray_F7F7F8", in: bundle, compatibleWith: .current) ?? .darkGray
    static let wGrayFAF: UIColor = UIColor(named: "gray_FAFAFA", in: bundle, compatibleWith: .current) ?? .darkGray

    
    static let wRedE01: UIColor = UIColor(named: "red_E01C1C", in: bundle, compatibleWith: .current) ?? .darkGray
    static let wYallowF9A: UIColor = UIColor(named: "yallow_F9A401", in: bundle, compatibleWith: .current)  ?? .darkGray

    
    
    // Green
    static let wLightLightGreen1: UIColor = UIColor(named: "light_light_green_1_E8FFF2", in: bundle, compatibleWith: .current)  ?? .white
    static let wLightLightGreen2: UIColor = UIColor(named: "light_light_green_2_CAFAED", in: bundle, compatibleWith: .current)  ?? .white
    static let wLightGreen: UIColor = UIColor(named: "light_green_09E1A6", in: bundle, compatibleWith: .current)  ?? .green
    static let wMidLightGreen: UIColor = UIColor(named: "mid_light_green_50AF95", in: bundle, compatibleWith: .current)  ?? .gray
    static let wGreen: UIColor = UIColor(named: "green_09DC77", in: bundle, compatibleWith: .current) ?? .green
    static let wDarkGreen1: UIColor = UIColor(named: "dark_green_1_50AF95", in: bundle, compatibleWith: .current)  ?? .white
    static let wDarkGreen2: UIColor = UIColor(named: "dark_green_2_00A478", in: bundle, compatibleWith: .current)  ?? .white
    static let wDarkGreen3: UIColor = UIColor(named: "dark_green_3_23A40B", in: bundle, compatibleWith: .current)  ?? .white

    
    
    // Red
    static let wLightLightRed: UIColor = UIColor(named: "light_light_red_FFDFE0", in: bundle, compatibleWith: .current)  ?? .white
    static let wDarkRed: UIColor = UIColor(named: "dark_red_FF060A", in: bundle, compatibleWith: .current)  ?? .white
    static let wRed_FFF: UIColor = UIColor(named: "red_FFF5F5", in: bundle, compatibleWith: .current)  ?? .white
    static let wRed_FF0: UIColor = UIColor(named: "red_FF0000", in: bundle, compatibleWith: .current)  ?? .white

    
    // Black
    static let wBlack42: UIColor = UIColor(named: "black_42_424758", in: bundle, compatibleWith: .current) ?? .black

    static let wWLightBlack: UIColor = UIColor(named: "light_black_252525", in: bundle, compatibleWith: .current)  ?? .lightGray
    static let wBlack: UIColor = UIColor(named: "black_000000", in: bundle, compatibleWith: .current)  ?? .white

    
    // White
    static let wWhite: UIColor = UIColor(named: "white_FFFFFF", in: bundle, compatibleWith: .current)  ?? .white
}
