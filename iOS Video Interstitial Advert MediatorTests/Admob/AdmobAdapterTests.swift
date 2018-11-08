//
//  AdmobAdapterTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
import GoogleMobileAds
@testable import iOS_Video_Interstitial_Advert_Mediator

class AdmobAdapterTests: XCTestCase {
    func testConvenienceInitializer() {
        let adapter = AdMobAdapter(type: .admob(appID: "123", adUnitID: "456"))
        XCTAssertNotNil(adapter, "AdmobAdapter convenience initializer should return instance for admob type")
    }
    func testInitializerConfiguresSDK() {
        _ = AdMobAdapter(appID: "123", adUnitID: "456", adMobSDK: MockAdMobSDK.self)
        XCTAssertTrue(MockAdMobSDK.configured, "AdmobAdapter init should configure Admob SDK.")
    }
    func testDidReceiveAd() {
        let adapter = AdMobAdapter(appID: "123", adUnitID: "456", adMobSDK: MockAdMobSDK.self)
        let delegate = MockNetworkDelegate()
        adapter.delegate = delegate
        adapter.interstitialDidReceiveAd(GADInterstitial(adUnitID: "123"))
        XCTAssertTrue(delegate.didLoad, "AdmobAdapter didReceiveAd should call delegate's didLoad method.")
    }
    func testFailedToReceiveAd() {
        let adapter = AdMobAdapter(appID: "123", adUnitID: "456", adMobSDK: MockAdMobSDK.self)
        let delegate = MockNetworkDelegate()
        adapter.delegate = delegate
        adapter.interstitial(
            GADInterstitial(adUnitID: "123"),
            didFailToReceiveAdWithError: GADRequestError(domain: "", code: 0, userInfo: nil)
        )
        XCTAssertNotNil(delegate.error, "AdmobAdapter didFailToReceiveAd should call delegate's didFail method.")
    }
    func testIsEqualReturnsTrueForEqualObject() {
        let adapter = AdMobAdapter(type: .admob(appID: "123", adUnitID: "456"))!
        let equal = adapter.isEqual(to: adapter)
        XCTAssertTrue(equal, "AdmobAdapter isEqual should return true for equal object.")
    }
    func testIsEqualReturnsFalseForDifferentObject() {
        let adapter = AdMobAdapter(type: .admob(appID: "123", adUnitID: "456"))!
        let adapter2 = AdMobAdapter(type: .admob(appID: "123", adUnitID: "456"))!
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "AdmobAdapter isEqual should return false for inequal object.")
    }
    func testIsEqualReturnFalseForDifferentClass() {
        let adapter = AdMobAdapter(type: .admob(appID: "123", adUnitID: "456"))!
        let adapter2 = MockVideoAdNetworkAdapter(type: .test)!
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "AdmobAdapter isEqual should return false for object of different class.")
    }
    func testRequestAdSetsDelegate() {
        let adapter = AdMobAdapter(
            appID: "123",
            adUnitID: "456",
            adMobSDK: MockAdMobSDK.self,
            adMobAdType: MockAdMobInterstitial.self
        )
        adapter.requestAd()
        XCTAssertNotNil(
            MockAdMobInterstitial.didSetDelegate,
            "AdmobAdapter requestAd should set interstitial delegate."
        )
    }
    func testRequestAdLoadsAd() {
        let adapter = AdMobAdapter(
            appID: "123",
            adUnitID: "456",
            adMobSDK: MockAdMobSDK.self,
            adMobAdType: MockAdMobInterstitial.self
        )
        adapter.requestAd()
        XCTAssertTrue(MockAdMobInterstitial.loaded, "AdmobAdapter requestAd should load interstitial.")
    }
}
