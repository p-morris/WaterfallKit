//
//  MockTimer.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//
import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockTimer: Timer {
    static weak var testDelegate: TimerTestDelegate?
    override open class func scheduledTimer(withTimeInterval interval: TimeInterval,
                                            repeats: Bool,
                                            block: @escaping (Timer) -> Void) -> Timer {
        let timer = MockTimer()
        block(timer)
        return timer
    }
    override func invalidate() {
        MockTimer.testDelegate?.wasInvalidated = true
    }
}
