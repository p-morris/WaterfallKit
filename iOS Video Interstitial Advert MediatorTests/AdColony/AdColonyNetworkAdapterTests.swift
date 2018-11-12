//
//  AdColonyNetworkAdapterTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
import AdColony
@testable import iOS_Video_Interstitial_Advert_Mediator
//swiftlint:disable weak_delegate

class AdColonyNetworkAdapterTests: XCTestCase {
    var adapter: AdColonyAdapter!
    var adapterDelegate: MockNetworkDelegate!
    var testDelegate: AdColonyTestDelegate!
    var options: AdColonyAppOptions!
    override func setUp() {
        testDelegate = AdColonyTestDelegate()
        MockAdColonySDK.testDelegate = testDelegate
        options = AdColonyAppOptions()
        adapter = AdColonyAdapter(appID: "123", zoneID: "456", options: options, adColony: MockAdColonySDK.self)
        adapterDelegate = MockNetworkDelegate()
        adapter.delegate = adapterDelegate
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
        XCTAssertTrue(options.disableLogging, "AdColonyAdapter initializer should disable logging.")
    }
    func testInitializerSchedulesTimeout() {
        XCTAssertTrue(adapter.timeoutTimer.isScheduled, "AdColonyAdapter initializer should schedule timeout timer.")
    }
    func testInitializerConfiguresSDK() {
        XCTAssertTrue(testDelegate.configured, "AdColonyAdapter initializer should configure SDK.")
    }
    func testInitializerSetsReadyOnComplete() {
        XCTAssertTrue(adapter.ready, "AdColonyAdapter initializer should set ready to true after SDK initialized.")
    }
    func testInitializerCancelsTimeoutOnComplete() {
        XCTAssertTrue(adapter.timeoutTimer.isCancelled, "AdColonyAdapter should cancel timeout after SDK initialized")
    }
    func testIsEqualReturnsTrueForEqualObject() {
        let equal = adapter.isEqual(to: adapter)
        XCTAssertTrue(equal, "AdColonyAdapter should return true for equal object.")
    }
    func testIsEqualReturnsFalseForNonEqualObject() {
        let adapter2 = AdColonyAdapter(appID: "123", zoneID: "456")
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "AdColonyAdapter should return false for non equal object.")
    }
    func testIsEqualReturnsFalseForObjectOfDifferentClass() {
        let adapter2 = MockVideoAdNetworkAdapter(type: .test)!
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "AdColonyAdapter should return false for object of different class.")
    }
    func testRequestAdSetsPendingAdRequestWhenNotReady() {
        testDelegate.shouldConfigure = false
        let adapter = AdColonyAdapter(appID: "123", zoneID: "456", options: options, adColony: MockAdColonySDK.self)
        adapter.requestAd()
        XCTAssertTrue(adapter.pendingAdRequest, "AdColonyAdapter requestAd should set pendingRequest if not ready.")
    }
    func testRequestAdNotifiesDelegateOnFailure() {
        testDelegate.shouldLoadAd = false
        adapter.requestAd()
        XCTAssertNotNil(
            adapterDelegate.error,
            "AdColonyAdapter requestAd should call delegate's didFail method when unsuccessful."
        )
    }
}
