//
//  SplashViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 13/12/2022.
//

import Foundation

public class SplashViewModel {
    
    let tutorialArrayImageName: [String] = ["splash_1_icon", "splash_2_icon"]
    var currentIndex: Int = 0
    
    public init() { }
    
    public func checkUserStatus(completionHandler: @escaping (Result<UserStatus>) -> Void) {
        SDKManager.shared.checkUserStatus() { data in
            DispatchQueue.main.async {
                switch data {
                case .success(let data):
                    completionHandler(Result.success(data))
                case .failure(let error):
                    completionHandler(Result.failure(.badURL))
                }
            }
        }
    }
}
