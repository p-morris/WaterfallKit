//
//  AppLovinAdapterTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class AppLovinAdapterTests: XCTestCase {
    func testConvenienceInitializer() {
        let adapter = AppLovinAdapter(type: .appLovin(sdkKey: "1234567"))
        XCTAssertNotNil(adapter, "AppLovinAdapter covenience initializer should return object for applovin type")
    }
    func testConvenienceInitializerWithInvalidType() {
        let adapter = AppLovinAdapter(type: .test)
        XCTAssertNil(adapter, "AppLovinAdapter convenience initializer should return nil for invalid type.")
    }
    func testInitializerSetsSDKWithValidKey() {
        let adapter = AppLovinAdapter(
            sdkKey: "sft8Tn2LETCqO7mlIdrehAIZl6We08AU_U_ikaTDxvfp-E_NgytxsQdRrB8hi5olXC5DLvzHgtVOQlwb4tQ76D"
        )
        XCTAssert(adapter.appLovin != nil, "AppLovinAdapter init should set appLovin property for valid sdk key.")
    }
    func testDidFailToLoad() {
        let type = VideoAdNetworkSettings.NetworkType.appLovin(
            sdkKey: "sft8Tn2LETCqO7mlIdrehAIZl6We08AU_U_ikaTDxvfp-E_NgytxsQdRrB8hi5olXC5DLvzHgtVOQlwb4tQ76D"
        )
        let adapter = AppLovinAdapter(type: type)
        let delegate = MockNetworkDelegate()
        adapter?.delegate = delegate
        adapter?.adService(adapter!.appLovin!.adService, didFailToLoadAdWithError: 0)
        XCTAssertNotNil(delegate.error, "AppLovinAdapter didFailToLoad should call delegate's didFail method.")
    }
    func testDidLoad() {
        let type = VideoAdNetworkSettings.NetworkType.appLovin(
            sdkKey: "sft8Tn2LETCqO7mlIdrehAIZl6We08AU_U_ikaTDxvfp-E_NgytxsQdRrB8hi5olXC5DLvzHgtVOQlwb4tQ76D"
        )
        let adapter = AppLovinAdapter(type: type)
        let delegate = MockNetworkDelegate()
        adapter?.delegate = delegate
        adapter?.adService(adapter!.appLovin!.adService, didLoad: ALAd())
        XCTAssertTrue(delegate.didLoad, "AppLovinAdapter didLoad should call delegate's didLoad method")
    }
    func testIsEqualReturnsTrueForEqualObject() {
        let adapter = AppLovinAdapter(type: .appLovin(sdkKey: "1234567"))!
        let equal = adapter.isEqual(to: adapter)
        XCTAssertTrue(equal, "AppLovinAdapter isEqual should return true for equal object.")
    }
    func testIsEqualReturnsFalseForNonEqualObject() {
        let adapter = AppLovinAdapter(type: .appLovin(sdkKey: "1234567"))!
        let adapter2 = AppLovinAdapter(type: .appLovin(sdkKey: "1234567"))!
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "AppLovinAdapter isEqual should return false for non equal object")
    }
    func testIsEqualReturnsFalseForNonEqualObjectOfDifferentClass() {
        let adapter = AppLovinAdapter(type: .appLovin(sdkKey: "1234567"))!
        let adapter2 = MockVideoAdNetworkAdapter(type: .test)!
        let equal = adapter.isEqual(to: adapter2)
        XCTAssertFalse(equal, "AppLovinAdapter isEqual should return false for non equal object")
    }
}
