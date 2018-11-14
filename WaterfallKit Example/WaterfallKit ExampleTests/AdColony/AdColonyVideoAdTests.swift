//
//  AdColonyVideoAdTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import WaterfallKit

class AdColonyVideoAdTests: XCTestCase {
    func testInitializerSetsOpenHandler() {
        let interstitial = MockAdColonyInterstitial()
        _ = AdColonyVideoAd(interstitial: interstitial)
        XCTAssertTrue(interstitial.didSetOpen, "AdColonyVideoAd initializer should set open handler.")
    }
    func testInitializerSetsCloseHandler() {
        let interstitial = MockAdColonyInterstitial()
        _ = AdColonyVideoAd(interstitial: interstitial)
        XCTAssertTrue(interstitial.didSetClose, "AdColonyVideoAd initializer should set close handler.")
    }
    func testInitializerSetsClickHandler() {
        let interstitial = MockAdColonyInterstitial()
        _ = AdColonyVideoAd(interstitial: interstitial)
        XCTAssertTrue(interstitial.didSetClick, "AdColonyVideoAd initializer should set click handler.")
    }
    func testDisplayShowsAd() {
        let interstitial = MockAdColonyInterstitial()
        let advert = AdColonyVideoAd(interstitial: interstitial)
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(interstitial.didShow, "AdColonyVideoAd display should show ad.")
    }
    func testOpenHandlerCallsDelegate() {
        let delegate = MockAdDelegate()
        let interstitial = MockAdColonyInterstitial()
        _ = AdColonyVideoAd(interstitial: interstitial, delegate: delegate)
        XCTAssertTrue(delegate.didAppear, "AdColonyVideoAd open handler should call delegate didAppear method.")
    }
    func testCloseHandlerCallsDelegate() {
        let delegate = MockAdDelegate()
        let interstitial = MockAdColonyInterstitial()
        _ = AdColonyVideoAd(interstitial: interstitial, delegate: delegate)
        XCTAssertTrue(delegate.didDismiss, "AdColonyVideoAd close handler should call delegate didDismiss method.")
    }
    func testClickHandlerCallsDelegate() {
        let delegate = MockAdDelegate()
        let interstitial = MockAdColonyInterstitial()
        _ = AdColonyVideoAd(interstitial: interstitial, delegate: delegate)
        XCTAssertTrue(
            delegate.didReceiveClick,
            "AdColonyVideoAd click handler should call delegate didReceiveClick method."
        )
    }
}
