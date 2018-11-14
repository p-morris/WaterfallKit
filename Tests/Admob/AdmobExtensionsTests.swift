//
//  AdmobExtensionsTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
//import WaterfallKit

extension ArrayExtensionTests {
    func testInitializeAdmobAddsNetworkType() {
        _ = settings.initializeAdMob(appID: "123", adUnitID: "456")
        switch settings.networkTypes[0] {
        case let .admob(appID, adUnitID): XCTAssert(appID == "123" && adUnitID == "456")
        default: XCTFail("VideoAdNetworkSettings initializeAdmob should add admob type.")
        }
    }
    func testInitializeAdmobAddsTypeToFactory() {
        _ = settings.initializeAdMob(appID: "123", adUnitID: "456")
        XCTAssertTrue(
            testDelegate.factoryRegisteredType is AdMobAdapter.Type,
            "VideoAdNetworkSettings initializeAdmob should add adapter class to factory"
        )
    }
}
