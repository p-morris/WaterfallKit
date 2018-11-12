//
//  TimeOutTimer.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 01/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Encapsulates an instance on Timer
public class TimeOutTimer {
    /// The timer to use for the timeout
    private var timer: Timer?
    /// The `TimeInterval` to wait before timing out.
    private let timeOutIn: TimeInterval
    /// Indicates whether the timer is currently scheduled to fire.
    private (set) public var isScheduled = false
    /// Indicates whether the timer has been invalidated.
    public var isCancelled: Bool {
        let valid = (timer?.isValid) ?? false
        return !valid
    }
    /**
     Initializes a new `TimeOutTimer` object.
     - Parameters:
     - timeOutIn: The `TimeInterval` to wait before timing out.
     - Returns: An initialized `TimeOutTimer` object.
     */
    public init(timeOutIn: TimeInterval) {
        self.timeOutIn = timeOutIn
    }
    /**
     Begins the timeout.
     
     - Parameters:
     - timeoutable: The `TimeOutableVideoAdNetworkAdapter` to notify on timeout.
     */
    public func startTimeOut(notify timeoutable: TimeOutableVideoAdNetworkAdapter, timerType: Timer.Type = Timer.self) {
        isScheduled = true
        timer = timerType.scheduledTimer(withTimeInterval: timeOutIn, repeats: false, block: { _ in
            self.isScheduled = false
            timeoutable.timeOut()
        })
    }
    /**
     Cancels the timeout.
     */
    public func cancelTimeOut() {
        timer?.invalidate()
    }
}
