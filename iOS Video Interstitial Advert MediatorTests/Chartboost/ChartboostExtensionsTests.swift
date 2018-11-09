//
//  ChartboostExtensionsTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

extension ArrayExtensionTests {
    func testInitializeChartboostAddsNetworkType() {
        _ = settings.initializeChartboost(appID: "123", appSignature: "456")
        switch settings.networkTypes[0] {
        case let .chartboost(appID, appSignature): XCTAssert(appID == "123" && appSignature == "456")
        default: XCTFail("VideoAdNetworkSettings initializeChartboost should add chartboost type.")
        }
    }
    func testInitializeChartboostAddsTypeToFactory() {
        let delegate = FactoryTestDelegate()
        MockFactory.testDelegate = delegate
        _ = settings.initializeChartboost(appID: "123", appSignature: "456")
        XCTAssertTrue(
            MockFactory.testDelegate?.factoryRegisteredType is ChartboostAdapter.Type,
            "VideoAdNetworkSettings initializeVungle should add adapter class to factory"
        )
    }
}
