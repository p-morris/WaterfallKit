//
//  ChartboostAdapterTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class ChartboostAdapterTests: XCTestCase {
    override func tearDown() {
        MockChartboostSDK.started = false
        MockChartboostSDK.consentSet = false
        MockChartboostSDK.loggingLevelSet = false
        MockChartboostSDK.cachedInterstitial = false
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
        _ = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        XCTAssertTrue(MockChartboostSDK.consentSet, "ChartboostAdapter initializer should set data consent.")
    }
    func testInitializerSetsLoggingLevel() {
        _ = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        XCTAssertTrue(MockChartboostSDK.loggingLevelSet, "ChartboostAdapter initializer should set logging level.")
    }
    func testInitializerStartsSDK() {
        _ = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        XCTAssertTrue(MockChartboostSDK.started, "ChartboostAdapter initializer should start SDK.")
    }
    func testDidInitializeCancelsTimeout() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        adapter.didInitialize(true)
        XCTAssertFalse(
            adapter.timeoutTimer.isCancelled,
            "ChartboostAdapter should cancel timeout on SDK initialization."
        )
    }
    func testDidInitializeSuccessfulSetsReady() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        adapter.didInitialize(true)
        XCTAssertTrue(adapter.ready, "ChartboostAdapter should set ready to true when SDK initializes.")
    }
    func testDidInitializeNotifesDelegateOnFailure() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        let delegate = MockNetworkDelegate()
        adapter.delegate = delegate
        adapter.didInitialize(false)
        XCTAssertNotNil(delegate.error, "ChartboostAdapter should notifiy delegate on SDK initialization failure.")
    }
    func testDidInitializeFailedSetsReady() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        let delegate = MockNetworkDelegate()
        adapter.delegate = delegate
        adapter.didInitialize(false)
        XCTAssertFalse(adapter.ready, "Chartboost adapter should set ready to false when SDK initialization fails.")
    }
    func testDidInitializeFailedSetsPendingAdRequest() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        let delegate = MockNetworkDelegate()
        adapter.delegate = delegate
        adapter.requestAd()
        adapter.didInitialize(false)
        XCTAssertFalse(
            adapter.pendingAdRequest,
            "Chartboost adapter should set ready to false when SDK initialization fails."
        )
    }
    func testDidCacheInterstital() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        let delegate = MockNetworkDelegate()
        adapter.delegate = delegate
        adapter.didCacheInterstitial("")
        XCTAssertTrue(delegate.didLoad, "Chartboost adapter should notify delegate when ad is cached.")
    }
    func testDidFailToCacheInterstitial() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        let delegate = MockNetworkDelegate()
        adapter.delegate = delegate
        let error = CBLoadError(rawValue: 1)!
        adapter.didFail(toLoadInterstitial: "", withError: error)
        XCTAssertNotNil(delegate.error, "ChartboostAdapter should notify delegate when ad fails to cache.")
    }
    func testIsEqualReturnsTrueForSameObject() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        let equal = adapter.isEqual(to: adapter)
        XCTAssertTrue(equal, "ChartboostAdapter isEqual should return true for same object.")
    }
    func testIsEqualReturnsFalseForDifferentObject() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        let adapter2 = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "ChartboostAdapter isEqual should return false for different object.")
    }
    func testIsEqualReturnsFalseForObjectOfDifferentClass() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        let adapter2 = MockVideoAdNetworkAdapter(type: .test)!
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "ChartboostAdapter isEqual should return false for different object.")
    }
    func testRequestAdAddsPendingRequestWhenNotReady() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        adapter.requestAd()
        XCTAssertTrue(
            adapter.pendingAdRequest,
            "ChartboostAdapter requestAd should set pendingAdRequest when SDK is not initialized."
        )
    }
    func testRequestAdDoesntAttemptAdLoadWhenNotReady() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        adapter.requestAd()
        XCTAssertFalse(
            MockChartboostSDK.cachedInterstitial,
            "ChartboostAdapter requestAd should not request ad when ready is false."
        )
    }
    func testRequestCalledWhenRequestIsPending() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        adapter.requestAd()
        adapter.didInitialize(true)
        XCTAssertTrue(
            MockChartboostSDK.cachedInterstitial,
            "ChartboostAdapter should request ad when initialized and pendingAdRequest is true."
        )
    }
    func testRequestAdLoadsAdWhenReady() {
        let adapter = ChartboostAdapter(appID: "123", appSignature: "456", chartboostSDK: MockChartboostSDK.self)
        adapter.didInitialize(true)
        adapter.requestAd()
        XCTAssertTrue(MockChartboostSDK.cachedInterstitial, "ChartboostAdapter requestAd should load ad when ready.")
    }
}
