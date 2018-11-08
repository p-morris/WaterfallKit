//
//  AdMobVideoAdTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

import XCTest
import GoogleMobileAds
@testable import iOS_Video_Interstitial_Advert_Mediator

class AdMobVideoAdTests: XCTestCase {
    var advert: AdMobVideoAd!
    var interstitial: MockAdMobInterstitial!
    //swiftlint:disable weak_delegate
    let delegate = MockAdDelegate()
    override func setUp() {
        interstitial = MockAdMobInterstitial(adUnitID: "123")
        advert = AdMobVideoAd(interstitial: interstitial)
        advert.delegate = delegate
    }
    func testWillPresent() {
        advert.interstitialWillPresentScreen(GADInterstitial(adUnitID: "123"))
        XCTAssertTrue(delegate.didAppear, "AdmobVideoAd willPresent should call delegate didAppear method.")
    }
    func testDidFailToPresent() {
        advert.interstitialDidFail(toPresentScreen: GADInterstitial(adUnitID: "123"))
        XCTAssertTrue(
            delegate.didFailToPresent,
            "AdmobVideoAd didFailToPresent should call delegate's didFailToPresent method."
        )
    }
    func testDidDismiss() {
        advert.interstitialDidDismissScreen(GADInterstitial(adUnitID: "123"))
        XCTAssertTrue(delegate.didDismiss, "AdMobVideoAd didDismiss should call delegate's didDismiss method.")
    }
    func testWillLeave() {
        advert.interstitialWillLeaveApplication(GADInterstitial(adUnitID: "123"))
        XCTAssertTrue(delegate.didReceiveClick, "AdMobVideoAd willLeave should call delegate's didClick method.")
    }
    func testDisplaySetsDelegate() {
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertNotNil(interstitial.delegate, "AdMobVideoAd display should set interstitial delegate.")
    }
    func testDisplayPresents() {
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertNotNil(interstitial.presentedFrom, "AdMobVideoAd display should call present on interstitial.")
    }
    func testDisplayPresentFromRootViewControllerFirst() {
        let rootController = UIViewController()
        let window = UIWindow()
        window.rootViewController = rootController
        let anotherController = UIViewController()
        advert.display(from: anotherController, or: window)
        XCTAssertEqual(
            interstitial.presentedFrom,
            rootController,
            "AdMobVideoAd display should present from rootViewController if available."
        )
    }
    func testDisplayPresentFromSecondaryControllerWhenNoRootController() {
        let window = UIWindow()
        let anotherController = UIViewController()
        advert.display(from: anotherController, or: window)
        XCTAssertEqual(
            interstitial.presentedFrom,
            anotherController,
            "AdMobVideoAd display should present from viewController if rootViewController is not available."
        )
    }
}
