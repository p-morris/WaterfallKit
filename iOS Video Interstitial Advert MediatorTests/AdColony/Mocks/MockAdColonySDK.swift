//
//  MockAdColonySDK.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockAdColonySDK: AdColonySDKProtocol {
    static var configured = false
    static var requested = false
    static var shouldConfigure = true
    static var shouldLoadAd = true
    static func configure(withAppID appID: String,
                          zoneIDs: [String],
                          options: AdColonyAppOptions?,
                          completion: (([AdColonyZone]) -> Void)?) {
        configured = true
        if shouldConfigure {
            completion?([])
        }
    }
    static func requestInterstitial(inZone zoneID: String,
                                    options: AdColonyAdOptions?,
                                    success: @escaping (AdColonyInterstitial) -> Void,
                                    failure: ((AdColonyAdRequestError) -> Void)?) {
        requested = true
        if shouldLoadAd {
            success(AdColonyInterstitial())
        } else {
            let error = AdColonyAdRequestError(domain: "", code: 0, userInfo: nil)
            failure?(error)
        }
    }
}
