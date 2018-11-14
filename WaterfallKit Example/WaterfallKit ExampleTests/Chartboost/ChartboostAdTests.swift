//
//  ChartboostAdTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator
//swiftlint:disable weak_delegate

class ChartboostAdTests: XCTestCase {
    var advert: ChartboostVideoAd!
    var advertDelegate: MockAdDelegate!
    var testDelegate: ChartboostTestDelegate!
    override func setUp() {
        testDelegate = ChartboostTestDelegate()
        MockChartboostSDK.testDelegate = testDelegate
        advertDelegate = MockAdDelegate()
        advert = ChartboostVideoAd(chartboostSDK: MockChartboostSDK.self)
        advert.delegate = advertDelegate
    }
    func testDisplayFromSetsSDKDelegate() {
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(testDelegate.delegateSet, "ChartboostVideoAd display should set SDK delegate.")
    }
    func testDisplayFromDisplaysAd() {
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(testDelegate.showInterstitial, "ChartboostVideoAd display should show ad.")
    }
    func testDidDisplay() {
        advert.didDisplayInterstitial("")
        XCTAssertTrue(
            advertDelegate.didAppear,
            "ChartboostVideoAd didDisplayInterstitial should execute delegate's didAppear method."
        )
    }
    func testDidDismiss() {
        advert.didDismissInterstitial("")
        XCTAssertTrue(
            advertDelegate.didDismiss,
            "ChartboostVideoAd didDismissInterstitial should execute delegate's didDismiss method."
        )
    }
    func testDidClick() {
        advert.didClickInterstitial("")
        XCTAssertTrue(
            advertDelegate.didReceiveClick,
            "ChartboostVideoAd didClickInterstitial should execute delegate's didReceiveClick method."
        )
    }
}
