//
//  AdColonyExtensionsTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class AdColonyExtensionsTests: XCTestCase {
    let settings = VideoAdNetworkSettings(factoryType: MockFactory.self)
    override func setUp() {
        settings.networkTypes.removeAll()
        _  = settings.initializeAdColony(appID: "123", zoneID: "456")
    }
    override func tearDown() {
        MockFactory.unregisterAllAdapterTypes()
    }
    func testInitializeAdmobAddsNetworkType() {
        switch settings.networkTypes[0] {
        case let .adColony(appID, zoneID): XCTAssert(appID == "123" && zoneID == "456")
        default: XCTFail("VideoAdNetworkSettings initializeAdColony should add adcolony type.")
        }
    }
    func testInitializeAdmobAddsTypeToFactory() {
        XCTAssertTrue(
            MockFactory.registeredType is AdColonyAdapter.Type,
            "VideoAdNetworkSettings initializeAdColony should add adapter class to factory"
        )
    }
}
