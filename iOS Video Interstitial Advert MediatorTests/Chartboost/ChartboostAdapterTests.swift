//
//  ChartboostAdapterTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator
//swiftlint:disable weak_delegate

class ChartboostAdapterTests: XCTestCase {
    var testDelegate: ChartboostTestDelegate!
    var adapter: ChartboostAdapter!
    var adapterDelegate: MockNetworkDelegate!
    override func setUp() {
        testDelegate = ChartboostTestDelegate()
        MockChartboostSDK.testDelegate = testDelegate
        adapterDelegate = MockNetworkDelegate()
        adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        adapter.delegate = adapterDelegate
    }
    func testConvenienceInitializerSetsAppID() {
        let adapter = ChartboostAdapter(type: .chartboost(appID: "123", appSignature: "456"))!
        XCTAssertEqual(adapter.appID, "123", "ChartboostAdapter convenience initializer should set appID.")
    }
    func testConvenienceInitializerSetsSignature() {
        let adapter = ChartboostAdapter(type: .chartboost(appID: "123", appSignature: "456"))!
        XCTAssertEqual(
            adapter.appSignature, "456",
            "ChartboostAdapeter convenience initializer should set app signature."
        )
    }
    func testInitializerSetsDataUseConsent() {
        XCTAssertTrue(testDelegate.consentSet, "ChartboostAdapter initializer should set data consent.")
    }
    func testInitializerSetsLoggingLevel() {
        XCTAssertTrue(testDelegate.loggingLevelSet, "ChartboostAdapter initializer should set logging level.")
    }
    func testInitializerStartsSDK() {
        XCTAssertTrue(testDelegate.started, "ChartboostAdapter initializer should start SDK.")
    }
    func testDidInitializeCancelsTimeout() {
        adapter.didInitialize(true)
        XCTAssertTrue(
            adapter.timeoutTimer.isCancelled,
            "ChartboostAdapter should cancel timeout on SDK initialization."
        )
    }
    func testDidInitializeSuccessfulSetsReady() {
        adapter.didInitialize(true)
        XCTAssertTrue(adapter.ready, "ChartboostAdapter should set ready to true when SDK initializes.")
    }
    func testDidInitializeNotifesDelegateOnFailure() {
        adapter.didInitialize(false)
        XCTAssertNotNil(
            adapterDelegate.error,
            "ChartboostAdapter should notifiy delegate on SDK initialization failure."
        )
    }
    func testDidInitializeFailedSetsReady() {
        adapter.didInitialize(false)
        XCTAssertFalse(adapter.ready, "Chartboost adapter should set ready to false when SDK initialization fails.")
    }
    func testDidInitializeFailedSetsPendingAdRequest() {
        adapter.requestAd()
        adapter.didInitialize(false)
        XCTAssertFalse(
            adapter.pendingAdRequest,
            "Chartboost adapter should set ready to false when SDK initialization fails."
        )
    }
    func testDidCacheInterstital() {
        adapter.didCacheInterstitial("")
        XCTAssertTrue(adapterDelegate.didLoad, "Chartboost adapter should notify delegate when ad is cached.")
    }
    func testDidFailToCacheInterstitial() {
        let error = CBLoadError(rawValue: 1)!
        adapter.didFail(toLoadInterstitial: "", withError: error)
        XCTAssertNotNil(adapterDelegate.error, "ChartboostAdapter should notify delegate when ad fails to cache.")
    }
    func testIsEqualReturnsTrueForSameObject() {
        let equal = adapter.isEqual(to: adapter)
        XCTAssertTrue(equal, "ChartboostAdapter isEqual should return true for same object.")
    }
    func testIsEqualReturnsFalseForDifferentObject() {
        let adapter2 = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "ChartboostAdapter isEqual should return false for different object.")
    }
    func testIsEqualReturnsFalseForObjectOfDifferentClass() {
        let adapter2 = MockVideoAdNetworkAdapter(type: .test)!
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "ChartboostAdapter isEqual should return false for different object.")
    }
    func testRequestAdAddsPendingRequestWhenNotReady() {
        adapter.requestAd()
        XCTAssertTrue(
            adapter.pendingAdRequest,
            "ChartboostAdapter requestAd should set pendingAdRequest when SDK is not initialized."
        )
    }
    func testRequestAdDoesntAttemptAdLoadWhenNotReady() {
        adapter.requestAd()
        XCTAssertFalse(
            testDelegate.cachedInterstitial,
            "ChartboostAdapter requestAd should not request ad when ready is false."
        )
    }
    func testRequestCalledWhenRequestIsPending() {
        adapter.requestAd()
        adapter.didInitialize(true)
        XCTAssertTrue(
            testDelegate.cachedInterstitial,
            "ChartboostAdapter should request ad when initialized and pendingAdRequest is true."
        )
    }
    func testRequestAdLoadsAdWhenReady() {
        adapter.didInitialize(true)
        adapter.requestAd()
        XCTAssertTrue(testDelegate.cachedInterstitial, "ChartboostAdapter requestAd should load ad when ready.")
    }
}
