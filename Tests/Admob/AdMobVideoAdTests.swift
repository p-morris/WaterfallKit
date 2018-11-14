//
//  AdMobVideoAdTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import GoogleMobileAds
//import WaterfallKit
//swiftlint:disable weak_delegate

class AdMobVideoAdTests: XCTestCase {
    var advert: AdMobVideoAd!
    var advertDelegate: MockAdDelegate!
    var interstitial: MockAdMobInterstitial!
    var testDelegate: AdmobTestDelegate!
    override func setUp() {
        testDelegate = AdmobTestDelegate()
        MockAdMobInterstitial.testDelegate = testDelegate
        interstitial = MockAdMobInterstitial(adUnitID: "123")
        advert = AdMobVideoAd(interstitial: interstitial)
        advertDelegate = MockAdDelegate()
        advert.delegate = advertDelegate
    }
    func testWillPresent() {
        advert.interstitialWillPresentScreen(GADInterstitial(adUnitID: "123"))
        XCTAssertTrue(advertDelegate.didAppear, "AdmobVideoAd willPresent should call delegate didAppear method.")
    }
    func testDidFailToPresent() {
        advert.interstitialDidFail(toPresentScreen: GADInterstitial(adUnitID: "123"))
        XCTAssertTrue(
            advertDelegate.didFailToPresent,
            "AdmobVideoAd didFailToPresent should call delegate's didFailToPresent method."
        )
    }
    func testDidDismiss() {
        advert.interstitialDidDismissScreen(GADInterstitial(adUnitID: "123"))
        XCTAssertTrue(advertDelegate.didDismiss, "AdMobVideoAd didDismiss should call delegate's didDismiss method.")
    }
    func testWillLeave() {
        advert.interstitialWillLeaveApplication(GADInterstitial(adUnitID: "123"))
        XCTAssertTrue(advertDelegate.didReceiveClick, "AdMobVideoAd willLeave should call delegate's didClick method.")
    }
    func testDisplaySetsDelegate() {
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertNotNil(interstitial.delegate, "AdMobVideoAd display should set interstitial delegate.")
    }
    func testDisplayPresents() {
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertNotNil(testDelegate.presentedFrom, "AdMobVideoAd display should call present on interstitial.")
    }
    func testDisplayPresentFromRootViewControllerFirst() {
        let controllers = getWindowAndViewController(rootViewController: true)
        advert.display(from: controllers.controller, or: controllers.window)
        XCTAssertEqual(
            testDelegate.presentedFrom,
            controllers.window.rootViewController,
            "AdMobVideoAd display should present from rootViewController if available."
        )
    }
    func testDisplayPresentFromSecondaryControllerWhenNoRootController() {
        let controllers = getWindowAndViewController(rootViewController: false)
        advert.display(from: controllers.controller, or: controllers.window)
        XCTAssertEqual(
            testDelegate.presentedFrom,
            controllers.controller,
            "AdMobVideoAd display should present from viewController if rootViewController is not available."
        )
    }
    func getWindowAndViewController(rootViewController: Bool) -> (window: UIWindow, controller: UIViewController) {
        let window = UIWindow()
        if rootViewController {
            window.rootViewController = UIViewController()
        }
        return (window: window, controller: UIViewController())
    }
}
