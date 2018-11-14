//
//  VideoAdLoaderTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
//import WaterfallKit

class VideoAdLoaderTests: XCTestCase {
    var settings: VideoAdNetworkSettings!
    var factory: MockFactory!
    var loader: VideoAdLoader!
    var sortingStrategy: MockSortingStrategy!
    //swiftlint:disable weak_delegate
    var testDelegate: VideoAdLoaderTestDelegate!
    var loaderDelegate: MockVideoAdLoaderDelegate!
    var factoryTestDelegate: FactoryTestDelegate!
    override func setUp() {
        factoryTestDelegate = FactoryTestDelegate()
        settings = VideoAdNetworkSettings(factoryType: MockFactory.self)
        settings.initializeForTest()
        factory = MockFactory()
        sortingStrategy = MockSortingStrategy()
        testDelegate = VideoAdLoaderTestDelegate()
        MockFactory.testDelegate = factoryTestDelegate
        loaderDelegate = MockVideoAdLoaderDelegate()
        loader = VideoAdLoader(settings: settings, factory: factory, advertSortingStrategy: sortingStrategy)
        loader.delegate = loaderDelegate
        MockVideoAdNetworkAdapter.testDelegate = testDelegate
    }
    override func tearDown() {
        testDelegate = nil
        loaderDelegate = nil
    }
    func testInitialization() {
        XCTAssertTrue(loader.settings == settings)
    }
    func testRequestAdsSetsPriority() {
        loader.requestAds()
        XCTAssertEqual(
            testDelegate.adapterPriority, 1,
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
        testDelegate.adapterShouldDelegate = false
        loader.requestAds()
        XCTAssertTrue(
            loader.adRequestsPending,
            "VideoAdLoader adRequestsPending should return true when requests are pending."
        )
    }
    func testRequestAdsReturnsErrorWhenNoNetworksInitialized() {
        settings.removeAll()
        loader.requestAds()
        XCTAssertNotNil(
            loaderDelegate.error,
            "VideoAdLoader should call delegate's didFailWithError method when no networks are initialized."
        )
    }
    func testRequestAdsSetsDelegate() {
        testDelegate.adapterShouldDelegate = false
        loader.requestAds()
        XCTAssertTrue(
            testDelegate.adapterDelegateSet,
            "VideoAdLoader adRequestsPending should set delegate of network adapter."
        )
    }
    func testRequestAdsInitiatesAdRequest() {
        loader.requestAds()
        XCTAssertTrue(
            testDelegate.adapterAdRequested,
            "VideoAdLoader should execute networks requestAd method."
        )
    }
    func testRequestAdsGuardsDuringPendingRequests() {
        testDelegate.adapterShouldDelegate = false
        loader.requestAds()
        loader.requestAds()
        XCTAssertEqual(loader.numberOfPendingRequests, 1, "VideoAdLoader should guard when requests are pending.")
    }
    func testRequestFailsRemovesPendingRequest() {
        testDelegate.adapterShouldDelegate = false
        loader.requestAds()
        executeLoaderNetworkFailToLoad()
        XCTAssertEqual(loader.numberOfPendingRequests, 0, "VideoAdLoader should remove pending request when it fails.")
    }
    func testRequestSucceedsSetsAdPriority() {
        testDelegate.adapterShouldDelegate = false
        let result = executeLoaderNetworkSucceeded()
        XCTAssertEqual(
            result.mockAd.priority, result.mockNetwork.priority,
            "VideoAdLoader should set ad priority to equal network priority"
        )
    }
    func testRequestSucceedsRemovesPendingRequest() {
        testDelegate.adapterShouldDelegate = false
        loader.requestAds()
        _ = executeLoaderNetworkSucceeded()
        XCTAssertEqual(
            loader.numberOfPendingRequests, 0,
            "VideoAdLoader should remove pending request after it completes successfully."
        )
    }
    func testNotifyDelegateUsesSortingStrategy() {
        testDelegate.adapterShouldDelegate = false
        loader.requestAds()
        _ = executeLoaderNetworkSucceeded()
        XCTAssertTrue(sortingStrategy.used, "VideoAdLoader notifyDelegate should use injected sorting strategy")
    }
    func testNotifyDelegateNotifiesDelegate() {
        testDelegate.adapterShouldDelegate = false
        loader.requestAds()
        _ = executeLoaderNetworkSucceeded()
        XCTAssertEqual(
            loaderDelegate.adverts?.count, 1,
            "VideoAdLoader notifyDelegate should execute delegate's didLoad method."
        )
    }
    func testNotifyDelegateRemovesReturnedAds() {
        testDelegate.adapterShouldDelegate = false
        loader.requestAds()
        _ = executeLoaderNetworkSucceeded()
        XCTAssertEqual(
            loader.numbersOfAdsLoaded, 0,
            "VideoAdLoader notifyDelegate should remove loaded ads after returning to delegate"
        )
    }
    func testNotifyDelegateNotifiesDelegateOnError() {
        executeLoaderNetworkFailToLoad()
        XCTAssertNotNil(
            loaderDelegate.error,
            """
            VideoAdLoader notifyDelegate should execute delegate's/
            didFail method when no adverts were successfully loaded
            """
        )
    }
    func testNotifyDelegateGuardsWhenRequestsPending() {
        testDelegate.adapterShouldDelegate = false
        settings.addAnotherNetwork()
        loader.requestAds()
        AnotherMockVideoAdNetworkAdapter.completeRequests()
        XCTAssert(
            loaderDelegate.adverts == nil && loaderDelegate.error == nil,
            "VideoAdLoader notifyDelegate should guard while requests are pending"
        )
    }
    func executeLoaderNetworkFailToLoad() {
        loader.adNetwork(
            MockVideoAdNetworkAdapter(type: .test)!,
            didFailToLoad: NSError(domain: "", code: 0, userInfo: nil)
        )
    }
    func executeLoaderNetworkSucceeded() -> (mockNetwork: VideoAdNetworkAdapter, mockAd: VideoAd) {
        let mockNetwork = MockVideoAdNetworkAdapter(type: .test)!
        mockNetwork.priority = 9
        let mockAd = MockAd()
        loader.adNetwork(mockNetwork, didLoad: mockAd)
        return (mockNetwork: mockNetwork, mockAd: mockAd)
    }
}
