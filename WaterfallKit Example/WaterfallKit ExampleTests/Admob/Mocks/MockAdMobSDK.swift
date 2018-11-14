//
//  MockAdMobSDK.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import WaterfallKit

class MockAdMobSDK: AdMobSDKProtocol {
    static weak var testDelegate: AdmobTestDelegate?
    static func configure(withApplicationID applicationID: String) {
        testDelegate?.configured = true
    }
}
