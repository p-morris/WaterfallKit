//
//  VideoAdNetworkAdapterFactoryTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
//import WaterfallKit

class VideoAdNetworkAdapterFactoryTests: XCTestCase {
    let type = MockVideoAdNetworkAdapter.self
    let factory = InterstitialAdapterFactory()
    override func setUp() {
        InterstitialAdapterFactory.unregisterAllAdapterTypes()
        InterstitialAdapterFactory.register(adapterType: type)
    }
    override func tearDown() {
        InterstitialAdapterFactory.unregisterAllAdapterTypes()
    }
    func testRegisterAdapterType() {
        let contains = InterstitialAdapterFactory.adapterClasses.contains { $0 == type }
        XCTAssertTrue(
            contains,
            "InterstitialAdapterFactory should add adapter type to adapterClasses array on register."
        )
    }
    func testUnregisterAdapterType() {
        InterstitialAdapterFactory.unregister(adapterType: type)
        let contains = InterstitialAdapterFactory.adapterClasses.contains { $0 == type }
        XCTAssertFalse(
            contains,
            "InterstitialAdapterFactory should remove adapter type from adapterClasses array on unregister."
        )
    }
    func testCreateAdapter() {
        let network = factory.createAdapter(type: .test)
        XCTAssertTrue(
            network is MockVideoAdNetworkAdapter,
            "InterstitialAdapterFactory should return an instance for createAdapter."
        )
    }
    func testCreateAdapterUnregisteredType() {
        InterstitialAdapterFactory.unregister(adapterType: type)
        let network = factory.createAdapter(type: .test)
        XCTAssertNil(
            network,
            "InterstitialAdapterFactory should return nil when createAdapter is passed unregistered type."
        )
    }
    func testUnregisterAll() {
        InterstitialAdapterFactory.unregisterAllAdapterTypes()
        XCTAssertEqual(
            InterstitialAdapterFactory.adapterClasses.count, 0,
            "InterstitialAdapterFactory should remove all from adapterClasses on unregisterAllAdapterTypes"
        )
    }
}
