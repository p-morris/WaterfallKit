//
//  TimeOutTimer.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 01/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Encapsulates an instance on Timer
class TimeOutTimer {
    /// The timer to use for the timeout
    private var timer: Timer?
    /// The `TimeInterval` to wait before timing out.
    let timeOutIn: TimeInterval
    /**
     Initializes a new `TimeOutTimer` object.
     
     - Parameters:
     - timeOutIn: The `TimeInterval` to wait before timing out.
     - Returns: An initialized `TimeOutTimer` object.
     */
    init(timeOutIn: TimeInterval) {
        self.timeOutIn = timeOutIn
    }
    /**
     Begins the timeout.
     
     - Parameters:
     - timeoutable: The `TimeOutableVideoAdNetworkAdapter` to notify on timeout.
     */
    func startTimeOut(notify timeoutable: TimeOutableVideoAdNetworkAdapter) {
        timer = Timer.scheduledTimer(withTimeInterval: timeOutIn, repeats: false, block: { _ in
            timeoutable.timeOut()
        })
    }
    /**
     Cancels the timeout.
     */
    func cancelTimeOut() {
        timer?.invalidate()
    }
}
