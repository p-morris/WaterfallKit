//
//  MockAdMobSDK.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockAdMobSDK: AdMobSDKProtocol {
    static var configured = false
    static func configure(withApplicationID applicationID: String) {
        configured = true
    }
}
