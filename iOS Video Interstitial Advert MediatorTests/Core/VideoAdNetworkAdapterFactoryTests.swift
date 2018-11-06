//
//  VideoAdNetworkAdapterFactoryTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class VideoAdNetworkAdapterFactoryTests: XCTestCase {
    let type = MockVideoAdNetworkAdapter.self
    let factory = InterstitialAdapterFactory()
    override func setUp() {
        InterstitialAdapterFactory.unregisterAllAdapterTypes()
    }
    override func tearDown() {
        InterstitialAdapterFactory.unregisterAllAdapterTypes()
    }
    func testRegisterAdapterType() {
        InterstitialAdapterFactory.register(adapterType: type)
        let contains = InterstitialAdapterFactory.adapterClasses.contains { $0 == type }
        XCTAssertTrue(
            contains,
            "InterstitialAdapterFactory should add adapter type to adapterClasses array on register."
        )
    }
    func testUnregisterAdapterType() {
        InterstitialAdapterFactory.register(adapterType: type)
        InterstitialAdapterFactory.unregister(adapterType: type)
        let contains = InterstitialAdapterFactory.adapterClasses.contains { $0 == type }
        XCTAssertFalse(
            contains,
            "InterstitialAdapterFactory should remove adapter type from adapterClasses array on unregister."
        )
    }
    func testCreateAdapter() {
        InterstitialAdapterFactory.register(adapterType: type)
        let network = factory.createAdapter(type: .test)
        XCTAssertTrue(
            network is MockVideoAdNetworkAdapter,
            "InterstitialAdapterFactory should return an instance for createAdapter."
        )
    }
    func testCreateAdapterUnregisteredType() {
        let network = factory.createAdapter(type: .test)
        XCTAssertNil(
            network,
            "InterstitialAdapterFactory should return nil when createAdapter is passed unregistered type."
        )
    }
    func testUnregisterAll() {
        InterstitialAdapterFactory.register(adapterType: type)
        InterstitialAdapterFactory.unregisterAllAdapterTypes()
        XCTAssertEqual(
            InterstitialAdapterFactory.adapterClasses.count, 0,
            "InterstitialAdapterFactory should remove all from adapterClasses on unregisterAllAdapterTypes"
        )
    }
}
