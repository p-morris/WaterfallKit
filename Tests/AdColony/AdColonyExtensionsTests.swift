//
//  AdColonyExtensionsTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
//import WaterfallKit

extension ArrayExtensionTests {
    func testInitializeAdColonyAddsNetworkType() {
        _  = settings.initializeAdColony(appID: "123", zoneID: "456")
        switch settings.networkTypes[0] {
        case let .adColony(appID, zoneID): XCTAssert(appID == "123" && zoneID == "456")
        default: XCTFail("VideoAdNetworkSettings initializeAdColony should add adcolony type.")
        }
    }
    func testInitializeAdColonyAddsTypeToFactory() {
        _  = settings.initializeAdColony(appID: "123", zoneID: "456")
        XCTAssertTrue(
            testDelegate.factoryRegisteredType is AdColonyAdapter.Type,
            "VideoAdNetworkSettings initializeAdColony should add adapter class to factory"
        )
    }
}
