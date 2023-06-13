//
//  TimerHelper.swift
//  WalletSDK
//
//  Created by ashahrouj on 13/01/2023.
//

import Foundation

class TimerHelper {
    private var timer: Timer?
    private var time = 14
    private var counter = 14
    
    var onFire: ((Int) -> Void)?
    var isRunning: Bool {
        timer != nil && timer!.isValid
    }
    
    init(counter: Int = 14) {
        self.counter = counter
        self.time = counter
    }
    
    @objc
    fileprivate func handleTimerEvent() {
        counter -= 1
        onFire?(counter)
    }
    
    func start(withTimeInterval timeInterval: TimeInterval,
               repeats: Bool = true,
               onFire: @escaping (Int) -> Void) {
        guard !isRunning else { return }
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(handleTimerEvent),
                                     userInfo: nil, repeats: repeats)
        self.onFire = onFire
    }
        
    func stop() {
        timer?.invalidate()
        timer = nil
        onFire = nil
        counter = self.time
    }
}
