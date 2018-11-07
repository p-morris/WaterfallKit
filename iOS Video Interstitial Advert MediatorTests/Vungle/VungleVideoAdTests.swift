//
//  VungleVideoAdTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 07/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class VungleVideoAdTests: XCTestCase {
    var advert: VungleVideoAd!
    //swiftlint:disable weak_delegate
    var delegate: MockAdDelegate!
    var mockSDK: MockVungleSDK!
    override func setUp() {
        mockSDK = MockVungleSDK()
        advert = VungleVideoAd(placementID: "1", vungleSDK: mockSDK)
        delegate = MockAdDelegate()
        advert.delegate = delegate
    }
    func testInitializerSetsPlacementID() {
        XCTAssertEqual(advert.placementID, "1", "VungleAd initializer should set placementID property.")
    }
    func testWillShowAd() {
        advert.vungleWillShowAd(forPlacementID: "")
        XCTAssertTrue(delegate.didAppear, "VungleVideoAd willShowAd should execute delegate didAppear method.")
    }
    func testDidClose() {
        advert.vungleDidCloseAd(with: VungleViewInfo(), placementID: "")
        XCTAssertTrue(delegate.didDismiss, "VungleVideoAd didCloseAd should execute delegate didDismiss method.")
    }
    func testDisplayFromSetsDelegate() {
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertNotNil(mockSDK.delegate, "VungleVideoAd displayFrom should set Vungle SDK delegate.")
    }
    func testDisplayFromPlaysAd() {
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(mockSDK.adPlayed, "VungleVideoAd displayFrom should play the ad.")
    }
    func testDisplayFromPlayFailed() {
        mockSDK.throwPlayException = true
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(
            delegate.didFailToPresent,
            "VungleVideoAd displayFrom should execute delegate's failedToDisplay method when exception is caught."
        )
    }
}
