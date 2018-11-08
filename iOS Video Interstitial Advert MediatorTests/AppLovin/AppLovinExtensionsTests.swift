//
//  AppLovinExtensionsTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class AppLovinExtensionsTests: XCTestCase {
    let settings = VideoAdNetworkSettings(factoryType: MockFactory.self)
    override func setUp() {
        settings.networkTypes.removeAll()
        _ = settings.initializeAppLovin(sdkKey: "123")
    }
    override func tearDown() {
        MockFactory.unregisterAllAdapterTypes()
    }
    func testInitializeAdmobAddsNetworkType() {
        switch settings.networkTypes[0] {
        case let .appLovin(sdkKey): XCTAssert(sdkKey == "123")
        default: XCTFail("VideoAdNetworkSettings initializeAppLovin should add applovin type.")
        }
    }
    func testInitializeAdmobAddsTypeToFactory() {
        XCTAssertTrue(
            MockFactory.registeredType is AppLovinAdapter.Type,
            "VideoAdNetworkSettings initializeAppLovin should add adapter class to factory"
        )
    }
}
