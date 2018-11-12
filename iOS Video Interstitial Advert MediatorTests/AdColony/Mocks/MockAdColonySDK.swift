//
//  MockAdColonySDK.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
import AdColony
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockAdColonySDK: AdColonySDKProtocol {
    static weak var testDelegate: AdColonyTestDelegate?
    static func configure(withAppID appID: String,
                          zoneIDs: [String],
                          options: AdColonyAppOptions?,
                          completion: (([AdColonyZone]) -> Void)?) {
        testDelegate?.configured = true
        if let testDelegate = testDelegate, testDelegate.shouldConfigure {
            completion?([])
        }
    }
    static func requestInterstitial(inZone zoneID: String,
                                    options: AdColonyAdOptions?,
                                    success: @escaping (AdColonyInterstitial) -> Void,
                                    failure: ((AdColonyAdRequestError) -> Void)?) {
        testDelegate?.requested = true
        if let testDelegate = testDelegate, testDelegate.shouldLoadAd {
            success(AdColonyInterstitial())
        } else {
            let error = AdColonyAdRequestError(domain: "", code: 0, userInfo: nil)
            failure?(error)
        }
    }
}
