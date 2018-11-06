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
    override func setUp() {
        settings = VideoAdNetworkSettings(factoryType: MockFactory.self)
        settings.initializeForTest()
        factory = MockFactory()
        loader = VideoAdLoader(settings: settings, factory: factory)
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
    func testRequestAdsPendingRequests() {
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
    func testAdapterFailedRemovesPendingRequest() {
        loader.requestAds()
        let mockAdapter = MockVideoAdNetworkAdapter(type: .test)!
        loader.adNetwork(mockAdapter, didFailToLoad: NSError(domain: "", code: 0, userInfo: nil))
        XCTAssertEqual(
            loader.numberOfPendingRequests, 0,
            "VideoAdLoader should remove completed requests from pendingRequests."
        )
    }
    func testAdapterSuccessfulRemovesPendingRequest() {
        loader.requestAds()
        let mockAdapter = MockVideoAdNetworkAdapter(type: .test)!
        let mockAd = MockAd()
        loader.adNetwork(mockAdapter, didLoad: mockAd)
        XCTAssertEqual(
            loader.numberOfPendingRequests, 0,
            "VideoAdLoader should remove completed requests from pendingRequests."
        )
    }
    func testDelegateCalledWhenRequestsComplete() {
        let delegate = MockVideoAdLoaderDelegate()
        loader.delegate = delegate
        loader.requestAds()
        let mockAdapter = MockVideoAdNetworkAdapter(type: .test)!
        let mockAd = MockAd()
        loader.adNetwork(mockAdapter, didLoad: mockAd)
        XCTAssertNotNil(
            delegate.adverts,
            "VideoAdLoader should execute delegate's didLoad method when all requests are complete"
        )
    }
}
