//
//  UINavigationController+Extension.swift
//  WalletSDK
//
//  Created by ashahrouj on 02/01/2023.
//

import UIKit

public extension UINavigationController {
    
    func removeViewController(_ controllers: [UIViewController.Type]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            var all = self.viewControllers
            for controller in controllers {
                if let index = all.firstIndex(where: {$0.isKind(of: controller.self) }) {
                    all.remove(at: index)
                }
            }
            self.viewControllers = all
        })
    }
    
    func removeViewControllerPreviousHome() {
        let controllers = [CryptoSplashViewController.self, BackupNoticeViewController.self, SetPinCodeViewController.self, BackupSecondNoticeViewController.self, BackUpMnemonicPhraseViewController.self, ConfirmPhrasesViewController.self, RecoveryPhrasesViewController.self]
        print("here removeViewControllerPreviousHome")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            var all = self.viewControllers
            for controller in controllers {
                if let index = all.firstIndex(where: {$0.isKind(of: controller.self) }) {
                    all.remove(at: index)
                }
            }
            self.viewControllers = all
        })
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
          popToViewController(vc, animated: animated)
        }
    }
    
    func initWalletSDK() {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sceneDelegate.initData()
        }
    }
}
