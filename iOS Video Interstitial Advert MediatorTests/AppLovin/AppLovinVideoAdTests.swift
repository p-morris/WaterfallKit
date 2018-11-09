//
//  AppLovinVideoAdTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator
//swiftlint:disable weak_delegate

class AppLovinVideoAdTests: XCTestCase {
    var advert: AppLovinVideoAd!
    var advertDelegate: MockAdDelegate!
    var mockInterstitial: MockAppLovinInterstitial!
    override func setUp() {
        mockInterstitial = MockAppLovinInterstitial()
        advert = AppLovinVideoAd(appLovinAd: ALAd(), interstitial: mockInterstitial)
        advertDelegate = MockAdDelegate()
        advert.delegate = advertDelegate
    }
    func testWasDisplayed() {
        advert.ad(ALAd(), wasDisplayedIn: UIView())
        XCTAssertTrue(
            advertDelegate.didAppear,
            "AppLovinVideoAd wasDisplayedIn should call delegate's didAppear method."
        )
    }
    func testWasHiddenIn() {
        advert.ad(ALAd(), wasHiddenIn: UIView())
        XCTAssertTrue(
            advertDelegate.didDismiss,
            "AppLovinVideoAd wasHiddenIn should call delegate's didDismiss method."
        )
    }
    func testWaClickedIn() {
        advert.ad(ALAd(), wasClickedIn: UIView())
        XCTAssertTrue(
            advertDelegate.didReceiveClick,
            "AppLovinVideoAd wasClickedIn should call delegate's didReceiveClick method."
        )
    }
    func testDisplaySetsDelegate() {
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(mockInterstitial.didSetDelegate, "AppLovinVideoAd display should set interstitial delegate.")
    }
    func testDisplayShowsAd() {
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(mockInterstitial.didShow, "AppLovinVideoAd display should show ad from window.")
    }
}
