//
//  VungleExtensionsTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 07/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

extension ArrayExtensionTests {
    func testInitializeVungleAddsNetworkType() {
        _ = settings.initializeVungle(appID: "123", placementID: "123")
        switch settings.networkTypes[0] {
        case let .vungle(appID, placementID): XCTAssert(appID == "123" && placementID == "123")
        default: XCTFail("VideoAdNetworkSettings initializeVungle should add vungle type.")
        }
    }
    func testInitializeVungleAddsTypeToFactory() {
        _ = settings.initializeVungle(appID: "123", placementID: "123")
        XCTAssertTrue(
            testDelegate.factoryRegisteredType is VungleAdapter.Type,
            "VideoAdNetworkSettings initializeVungle should add adapter class to factory"
        )
    }
}
