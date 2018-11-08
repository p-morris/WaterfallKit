//
//  AdColonyNetworkAdapterTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class AdColonyNetworkAdapterTests: XCTestCase {
    override func setUp() {
        MockAdColonySDK.configured = false
        MockAdColonySDK.requested = false
        MockAdColonySDK.shouldConfigure = true
        MockAdColonySDK.shouldLoadAd = true
    }
    override func tearDown() {
        MockAdColonySDK.configured = false
        MockAdColonySDK.requested = false
        MockAdColonySDK.shouldConfigure = true
        MockAdColonySDK.shouldLoadAd = true
    }
    func testConvenienceInitializer() {
        let adapter = AdColonyAdapter(type: .adColony(appID: "123", zoneID: "456"))
        XCTAssertNotNil(adapter, "AdColonyAdapter convenience initializer should return object for adcolony type.")
    }
    func testConvenienceInitializerInvalidType() {
        let adapter = AdColonyAdapter(type: .test)
        XCTAssertNil(adapter, "AdColonyAdapter convenience initializer should return nil for invalid type.")
    }
    func testInitializerConfiguresLogging() {
        let options = AdColonyAppOptions()
        _ = AdColonyAdapter(appID: "123", zoneID: "456", options: options)
        XCTAssertTrue(options.disableLogging, "AdColonyAdapter initializer should disable logging.")
    }
    func testInitializerSchedulesTimeout() {
        let adapter = AdColonyAdapter(appID: "123", zoneID: "456")
        XCTAssertTrue(adapter.timeoutTimer.isScheduled, "AdColonyAdapter initializer should schedule timeout timer.")
    }
    func testInitializerConfiguresSDK() {
        _ = AdColonyAdapter(appID: "123", zoneID: "456", adColony: MockAdColonySDK.self)
        XCTAssertTrue(MockAdColonySDK.configured, "AdColonyAdapter initializer should configure SDK.")
    }
    func testInitializerSetsReadyOnComplete() {
        let adapter = AdColonyAdapter(appID: "123", zoneID: "456", adColony: MockAdColonySDK.self)
        XCTAssertTrue(adapter.ready, "AdColonyAdapter initializer should set ready to true after SDK initialized.")
    }
    func testInitializerCancelsTimeoutOnComplete() {
        let adapter = AdColonyAdapter(appID: "123", zoneID: "456", adColony: MockAdColonySDK.self)
        XCTAssertTrue(adapter.timeoutTimer.isCancelled, "AdColonyAdapter should cancel timeout after SDK initialized")
    }
    func testIsEqualReturnsTrueForEqualObject() {
        let adapter = AdColonyAdapter(appID: "123", zoneID: "456")
        let equal = adapter.isEqual(to: adapter)
        XCTAssertTrue(equal, "AdColonyAdapter should return true for equal object.")
    }
    func testIsEqualReturnsFalseForNonEqualObject() {
        let adapter = AdColonyAdapter(appID: "123", zoneID: "456")
        let adapter2 = AdColonyAdapter(appID: "123", zoneID: "456")
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "AdColonyAdapter should return false for non equal object.")
    }
    func testIsEqualReturnsFalseForObjectOfDifferentClass() {
        let adapter = AdColonyAdapter(appID: "123", zoneID: "456")
        let adapter2 = MockVideoAdNetworkAdapter(type: .test)!
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "AdColonyAdapter should return false for object of different class.")
    }
    func testRequestAdSetsPendingAdRequestWhenNotReady() {
        MockAdColonySDK.shouldConfigure = false
        let adapter = AdColonyAdapter(appID: "123", zoneID: "456", adColony: MockAdColonySDK.self)
        adapter.requestAd()
        XCTAssertTrue(adapter.pendingAdRequest, "AdColonyAdapter requestAd should set pendingRequest if not ready.")
    }
    func testRequestAdNotifiesDelegateOnFailure() {
        MockAdColonySDK.shouldLoadAd = false
        let delegate = MockNetworkDelegate()
        let adapter = AdColonyAdapter(appID: "123", zoneID: "456", adColony: MockAdColonySDK.self)
        adapter.delegate = delegate
        adapter.requestAd()
        XCTAssertNotNil(
            delegate.error,
            "AdColonyAdapter requestAd should call delegate's didFail method when unsuccessful."
        )
    }
}
