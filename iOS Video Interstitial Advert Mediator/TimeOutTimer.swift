//
//  TimeOutTimer.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 01/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

class TimeOutTimer {
    static let timeOutError = "TimeOutErrorDomain"
    private var timer: Timer?
    let timeOutIn: TimeInterval
    init(timeOutIn: TimeInterval) {
        self.timeOutIn = timeOutIn
    }
    func startTimeOut(notify timeoutable: TimeOutableVideoAdNetworkAdapter) {
        timer = Timer.scheduledTimer(withTimeInterval: timeOutIn, repeats: false, block: { _ in
            timeoutable.timeOut()
        })
    }
    func cancelTimeOut() {
        timer?.invalidate()
    }
}
