//
//  MockFactory.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockFactory: VideoAdNetworkAdapterFactory {
    private (set) static var adapterClasses: [VideoAdNetworkAdapter.Type] = [MockVideoAdNetworkAdapter.self]
    static var mockCount = 0
    static func unregisterAllAdapterTypes() {
        //
    }
    static func unregister<T>(adapterType: T.Type) where T: VideoAdNetworkAdapter {
        //
    }
    static func register<T>(adapterType: T.Type) where T: VideoAdNetworkAdapter {
        // Register type
    }
    func createAdapter(type: VideoAdNetworkSettings.NetworkType) -> VideoAdNetworkAdapter? {
        let adapter: VideoAdNetworkAdapter = MockFactory.mockCount == 0 ?
            MockVideoAdNetworkAdapter(type: .test)! :
            AnotherMockVideoAdNetworkAdapter(type: .test)!
        MockFactory.mockCount += 1
        return adapter
    }
}
