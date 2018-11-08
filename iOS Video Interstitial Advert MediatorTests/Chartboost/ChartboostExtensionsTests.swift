//
//  ChartboostExtensionsTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class ChartboostExtensionsTests: XCTestCase {
    let settings = VideoAdNetworkSettings(factoryType: MockFactory.self)
    override func setUp() {
        settings.networkTypes.removeAll()
        _ = settings.initializeChartboost(appID: "123", appSignature: "456")
    }
    func testInitializeVungleAddsNetworkType() {
        switch settings.networkTypes[0] {
        case let .chartboost(appID, appSignature): XCTAssert(appID == "123" && appSignature == "456")
        default: XCTFail("VideoAdNetworkSettings initializeVungle should add vungle type.")
        }
    }
    func testInitializeVungleAddsTypeToFactory() {
        XCTAssertTrue(
            MockFactory.registeredType is ChartboostAdapter.Type,
            "VideoAdNetworkSettings initializeVungle should add adapter class to factory"
        )
    }
}
