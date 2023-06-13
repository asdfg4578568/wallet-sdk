//
//  LocalDefaultsKeys.swift
//  WalletSDK
//
//  Created by ashahrouj on 09/02/2023.
//

import Foundation

public struct DefaultsKeys {
    static public let tutorialHomeScreen = "tutorial_home_screen"
    static public let userId = "user_id_cache"

    static public var shouldDisplayTutorialHomeScreen: Bool {
        !UserDefaults.standard.bool(forKey: DefaultsKeys.tutorialHomeScreen)
    }
    
    static public var getUserId: String {
        UserDefaults.standard.string(forKey: DefaultsKeys.userId) ?? ""
    }
}
