//
//  AdmobAdapterTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
import GoogleMobileAds
@testable import WaterfallKit
//swiftlint:disable weak_delegate

class AdmobAdapterTests: XCTestCase {
    var adapter: AdMobAdapter!
    var testDelegate: AdmobTestDelegate!
    var adapterDelegate: MockNetworkDelegate!
    override func setUp() {
        testDelegate = AdmobTestDelegate()
        MockAdMobSDK.testDelegate = testDelegate
        MockAdMobInterstitial.testDelegate = testDelegate
        adapter = AdMobAdapter(
            appID: "123", adUnitID: "456", adMobSDK: MockAdMobSDK.self, adMobAdType: MockAdMobInterstitial.self
        )
        adapterDelegate = MockNetworkDelegate()
        adapter.delegate = adapterDelegate
    }
    func testConvenienceInitializer() {
        let adapter = AdMobAdapter(type: .admob(appID: "123", adUnitID: "456"))
        XCTAssertNotNil(adapter, "AdmobAdapter convenience initializer should return instance for admob type")
    }
    func testInitializerConfiguresSDK() {
        XCTAssertTrue(testDelegate.configured, "AdmobAdapter init should configure Admob SDK.")
    }
    func testDidReceiveAd() {
        adapter.interstitialDidReceiveAd(GADInterstitial(adUnitID: "123"))
        XCTAssertTrue(adapterDelegate.didLoad, "AdmobAdapter didReceiveAd should call delegate's didLoad method.")
    }
    func testFailedToReceiveAd() {
        adapter.interstitial(
            GADInterstitial(adUnitID: "123"),
            didFailToReceiveAdWithError: GADRequestError(domain: "", code: 0, userInfo: nil)
        )
        XCTAssertNotNil(adapterDelegate.error, "AdmobAdapter didFailToReceiveAd should call delegate's didFail method.")
    }
    func testIsEqualReturnsTrueForEqualObject() {
        let equal = adapter.isEqual(to: adapter)
        XCTAssertTrue(equal, "AdmobAdapter isEqual should return true for equal object.")
    }
    func testIsEqualReturnsFalseForDifferentObject() {
        let adapter2 = AdMobAdapter(type: .admob(appID: "123", adUnitID: "456"))!
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "AdmobAdapter isEqual should return false for inequal object.")
    }
    func testIsEqualReturnFalseForDifferentClass() {
        let adapter2 = MockVideoAdNetworkAdapter(type: .test)!
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "AdmobAdapter isEqual should return false for object of different class.")
    }
    func testRequestAdSetsDelegate() {
        adapter.requestAd()
        XCTAssertNotNil(
            testDelegate.didSetDelegate,
            "AdmobAdapter requestAd should set interstitial delegate."
        )
    }
    func testRequestAdLoadsAd() {
        adapter.requestAd()
        XCTAssertTrue(testDelegate.loaded, "AdmobAdapter requestAd should load interstitial.")
    }
}
