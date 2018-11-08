//
//  AppLovinVideoAdTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class AppLovinVideoAdTests: XCTestCase {
    func testWasDisplayed() {
        let advert = AppLovinVideoAd(appLovinAd: ALAd(), interstitial: MockAppLovinInterstitial())
        let delegate = MockAdDelegate()
        advert.delegate = delegate
        advert.ad(ALAd(), wasDisplayedIn: UIView())
        XCTAssertTrue(delegate.didAppear, "AppLovinVideoAd wasDisplayedIn should call delegate's didAppear method.")
    }
    func testWasHiddenIn() {
        let advert = AppLovinVideoAd(appLovinAd: ALAd(), interstitial: MockAppLovinInterstitial())
        let delegate = MockAdDelegate()
        advert.delegate = delegate
        advert.ad(ALAd(), wasHiddenIn: UIView())
        XCTAssertTrue(delegate.didDismiss, "AppLovinVideoAd wasHiddenIn should call delegate's didDismiss method.")
    }
    func testWaClickedIn() {
        let advert = AppLovinVideoAd(appLovinAd: ALAd(), interstitial: MockAppLovinInterstitial())
        let delegate = MockAdDelegate()
        advert.delegate = delegate
        advert.ad(ALAd(), wasClickedIn: UIView())
        XCTAssertTrue(
            delegate.didReceiveClick,
            "AppLovinVideoAd wasClickedIn should call delegate's didReceiveClick method."
        )
    }
    func testDisplaySetsDelegate() {
        let interstitial = MockAppLovinInterstitial()
        let advert = AppLovinVideoAd(appLovinAd: ALAd(), interstitial:interstitial)
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(interstitial.didSetDelegate, "AppLovinVideoAd display should set interstitial delegate.")
    }
    func testDisplayShowsAd() {
        let interstitial = MockAppLovinInterstitial()
        let advert = AppLovinVideoAd(appLovinAd: ALAd(), interstitial:interstitial)
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(interstitial.didShow, "AppLovinVideoAd display should show ad from window.")
    }
}
