//
//  DisabledSwipeNavigation.swift
//  CryptoWalletSDK
//
//  Created by ashahrouj on 13/03/2023.
//

import Foundation
import UIKit

class DisabledSwipeNavigation: UIViewController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}
