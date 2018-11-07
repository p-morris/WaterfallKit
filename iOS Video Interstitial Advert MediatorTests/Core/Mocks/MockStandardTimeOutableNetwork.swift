//
//  MockStandardTimeOutableNetwork.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockStandardTimeOutableNetwork: NSObject, TimeOutableVideoAdNetworkAdapter {
    var timeoutTimer: TimeOutTimer
    required init?(type: VideoAdNetworkSettings.NetworkType) {
        self.timeoutTimer = TimeOutTimer(timeOutIn: 0)
        self.priority = 1
    }
    weak var delegate: VideoAdNetworkAdapterDelegate?
    var priority: Int
    func requestAd() { }
    func isEqual(to anotherAdNetwork: VideoAdNetworkAdapter) -> Bool { return true }
}
