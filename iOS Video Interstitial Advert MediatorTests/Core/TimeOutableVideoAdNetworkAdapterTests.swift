//
//  TimeOutableVideoAdNetworkAdapterTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class TimeOutableVideoAdNetworkAdapterTests: XCTestCase {
    func testTimeoutDelegateFailed() {
        let networkDelegate = MockNetworkDelegate()
        let timeoutableNetwork = MockStandardTimeOutableNetwork(type: .adColony(appID: "", zoneID: ""))!
        timeoutableNetwork.delegate = networkDelegate
        timeoutableNetwork.timeOut()
        XCTAssertNotNil(
            networkDelegate.error,
            "TimoutableVideoAdNetwork should execute delegates didFail method on timeout."
        )
    }
}
