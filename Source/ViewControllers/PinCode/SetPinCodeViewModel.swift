//
//  SetPinCodeViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 02/01/2023.
//

import Foundation

class SetPinCodeViewModel {
    
    enum PinCodeStep {
        case setPin
        case confirm
    }
    
    enum NextScreen {
        case dontTakeScreenShot
        case enterPhrase
    }
    
    var step: PinCodeStep = .setPin {
        didSet {
            didTapNextStep(step)
        }
    }
    
    var pinCode: String = ""
    var didTapNextStep: (PinCodeStep) -> Void = { _ in }

    let nextScreen: NextScreen
    init(with nextScreen: NextScreen) {
        self.nextScreen = nextScreen
    }
}
