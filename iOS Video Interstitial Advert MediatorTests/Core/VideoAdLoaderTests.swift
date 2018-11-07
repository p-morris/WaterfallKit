//
//  VideoAdLoaderTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class VideoAdLoaderTests: XCTestCase {
    var settings: VideoAdNetworkSettings!
    var factory: MockFactory!
    var loader: VideoAdLoader!
    var sortingStrategy: MockSortingStrategy!
    var delegate: MockVideoAdLoaderDelegate!
    override func setUp() {
        MockFactory.mockCount = 0
        MockVideoAdNetworkAdapter.shouldDelegate = false
        settings = VideoAdNetworkSettings(factoryType: MockFactory.self)
        settings.initializeForTest()
        factory = MockFactory()
        sortingStrategy = MockSortingStrategy()
        loader = VideoAdLoader(settings: settings, factory: factory, advertSortingStrategy: sortingStrategy)
        delegate = MockVideoAdLoaderDelegate()
        loader.delegate = delegate
    }
    func testInitialization() {
        XCTAssertTrue(loader.settings == settings)
    }
    func testRequestAdsSetsPriority() {
        loader.requestAds()
        XCTAssertEqual(
            MockVideoAdNetworkAdapter.staticPriority, 1,
            "VideoAdLoader should set priority of network on requestAds"
        )
    }
    func testNoPendingRequests() {
        XCTAssertFalse(
            loader.adRequestsPending,
            "VideoAdLoader adRequestsPending should return false when no requests are pending."
        )
    }
    func testSomePendingRequests() {
        loader.requestAds()
        XCTAssertTrue(
            loader.adRequestsPending,
            "VideoAdLoader adRequestsPending should return true when requests are pending."
        )
    }
    func testRequestAdsSetsDelegate() {
        loader.requestAds()
        XCTAssertTrue(
            MockVideoAdNetworkAdapter.delegateSet,
            "VideoAdLoader adRequestsPending should set delegate of network adapter."
        )
    }
    func testRequestAdsInitiatesAdRequest() {
        loader.requestAds()
        XCTAssertTrue(
            MockVideoAdNetworkAdapter.adRequested,
            "VideoAdLoader should execute networks requestAd method."
        )
    }
    func testRequestAdsGuardsDuringPendingRequests() {
        loader.requestAds()
        loader.requestAds()
        XCTAssertEqual(loader.numberOfPendingRequests, 1, "VideoAdLoader should guard when requests are pending.")
    }
    func testRequestFailsRemovesPendingRequest() {
        MockVideoAdNetworkAdapter.shouldDelegate = true
        MockVideoAdNetworkAdapter.shouldFail = true
        loader.requestAds()
        XCTAssertEqual(loader.numberOfPendingRequests, 0, "VideoAdLoader should remove pending request when it fails.")
    }
    func testRequestSucceedsSetsAdPriority() {
        MockVideoAdNetworkAdapter.shouldDelegate = true
        MockVideoAdNetworkAdapter.shouldFail = false
        loader.requestAds()
        XCTAssertEqual(
            MockAd.staticPriority, MockVideoAdNetworkAdapter.staticPriority,
            "VideoAdLoader should set ad priority to equal network priority"
        )
    }
    func testRequestSucceedsRemovesPendingRequest() {
        MockVideoAdNetworkAdapter.shouldDelegate = true
        MockVideoAdNetworkAdapter.shouldFail = false
        loader.requestAds()
        XCTAssertEqual(
            loader.numberOfPendingRequests, 0,
            "VideoAdLoader should remove pending request after it completes successfully."
        )
    }
    func testNotifyDelegateUsesSortingStrategy() {
        MockVideoAdNetworkAdapter.shouldDelegate = true
        MockVideoAdNetworkAdapter.shouldFail = false
        loader.requestAds()
        XCTAssertTrue(sortingStrategy.used, "VideoAdLoader notifyDelegate should use injected sorting strategy")
    }
    func testNotifyDelegateNotifiesDelegate() {
        MockVideoAdNetworkAdapter.shouldDelegate = true
        MockVideoAdNetworkAdapter.shouldFail = false
        loader.requestAds()
        XCTAssertEqual(
            delegate.adverts?.count, 1,
            "VideoAdLoader notifyDelegate should execute delegate's didLoad method."
        )
    }
    func testNotifyDelegateRemovesReturnedAds() {
        MockVideoAdNetworkAdapter.shouldDelegate = true
        MockVideoAdNetworkAdapter.shouldFail = false
        loader.requestAds()
        XCTAssertEqual(
            loader.numbersOfAdsLoaded, 0,
            "VideoAdLoader notifyDelegate should remove loaded ads after returning to delegate"
        )
    }
    func testNotifyDelegateNotifiesDelegateOnError() {
        MockVideoAdNetworkAdapter.shouldDelegate = true
        MockVideoAdNetworkAdapter.shouldFail = true
        loader.requestAds()
        XCTAssertNotNil(
            delegate.error,
            """
            VideoAdLoader notifyDelegate should execute delegate's/
            didFail method when no adverts were successfully loaded
            """
        )
    }
    func testNotifyDelegateGuardsWhenRequestsPending() {
        settings.addAnotherNetwork()
        MockVideoAdNetworkAdapter.shouldDelegate = false
        MockVideoAdNetworkAdapter.shouldFail = false
        loader.requestAds()
        AnotherMockVideoAdNetworkAdapter.completeRequests()
        XCTAssert(
            delegate.adverts == nil && delegate.error == nil,
            "VideoAdLoader notifyDelegate should guard while requests are pending"
        )
    }
}
