//
//  AdmobExtensionsTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class AdmobExtensionsTests: XCTestCase {
    let settings = VideoAdNetworkSettings(factoryType: MockFactory.self)
    override func setUp() {
        settings.networkTypes.removeAll()
        _ = settings.initializeAdMob(appID: "123", adUnitID: "456")
    }
    func testInitializeAdmobAddsNetworkType() {
        switch settings.networkTypes[0] {
        case let .admob(appID, adUnitID): XCTAssert(appID == "123" && adUnitID == "456")
        default: XCTFail("VideoAdNetworkSettings initializeAdmob should add admob type.")
        }
    }
    func testInitializeAdmobAddsTypeToFactory() {
        XCTAssertTrue(
            MockFactory.registeredType is AdMobAdapter.Type,
            "VideoAdNetworkSettings initializeAdmob should add adapter class to factory"
        )
    }
}
