//
//  TimeOutTimerTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class TimeOutTimerTests: XCTestCase {
    let timer = TimeOutTimer(timeOutIn: 0.5)
    let timeoutable = MockTimeOutableNetwork(type: .adColony(appID: "", zoneID: ""))!
    func testTimeOutInInitialization() {
        XCTAssertEqual(timer.timeOutIn, 0.5, "TimeOutTimer should set timeOutIn property.")
    }
    func testTimeoutExecutedOnTimeOut() {
        timer.startTimeOut(notify: timeoutable, timerType: MockTimer.self)
        XCTAssertTrue(timeoutable.timedout, "TimeOutTimer should execute timeOut when it fires.")
    }
    func testTimerInvalidatedOnCancel() {
        timer.startTimeOut(notify: timeoutable, timerType: MockTimer.self)
        timer.cancelTimeOut()
        XCTAssertTrue(MockTimer.invalidateCalled, "TimeOutTimer should invalidate timer when cancelled.")
    }
}
