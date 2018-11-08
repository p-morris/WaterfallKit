//
//  ChartboostAdTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class ChartboostAdTests: XCTestCase {
    override func tearDown() {
        MockChartboostSDK.started = false
        MockChartboostSDK.consentSet = false
        MockChartboostSDK.loggingLevelSet = false
        MockChartboostSDK.cachedInterstitial = false
    }
    func testDisplayFromSetsSDKDelegate() {
        let advert = ChartboostVideoAd(chartboostSDK: MockChartboostSDK.self)
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(MockChartboostSDK.delegateSet, "ChartboostVideoAd display should set SDK delegate.")
    }
    func testDisplayFromDisplaysAd() {
        let advert = ChartboostVideoAd(chartboostSDK: MockChartboostSDK.self)
        advert.display(from: UIViewController(), or: UIWindow())
        XCTAssertTrue(MockChartboostSDK.showInterstitial, "ChartboostVideoAd display should show ad.")
    }
    func testDidDisplay() {
        let advert = ChartboostVideoAd(chartboostSDK: MockChartboostSDK.self)
        let delegate = MockAdDelegate()
        advert.delegate = delegate
        advert.didDisplayInterstitial("")
        XCTAssertTrue(
            delegate.didAppear,
            "ChartboostVideoAd didDisplayInterstitial should execute delegate's didAppear method."
        )
    }
    func testDidDismiss() {
        let advert = ChartboostVideoAd(chartboostSDK: MockChartboostSDK.self)
        let delegate = MockAdDelegate()
        advert.delegate = delegate
        advert.didDismissInterstitial("")
        XCTAssertTrue(
            delegate.didDismiss,
            "ChartboostVideoAd didDismissInterstitial should execute delegate's didDismiss method."
        )
    }
    func testDidClick() {
        let advert = ChartboostVideoAd(chartboostSDK: MockChartboostSDK.self)
        let delegate = MockAdDelegate()
        advert.delegate = delegate
        advert.didClickInterstitial("")
        XCTAssertTrue(
            delegate.didReceiveClick,
            "ChartboostVideoAd didClickInterstitial should execute delegate's didReceiveClick method."
        )
    }
}
