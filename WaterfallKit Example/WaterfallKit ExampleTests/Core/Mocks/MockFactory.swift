//
//  MockFactory.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import WaterfallKit

class MockFactory: VideoAdNetworkAdapterFactory {
    static weak var testDelegate: FactoryTestDelegate?
    private (set) static var adapterClasses: [VideoAdNetworkAdapter.Type] = [MockVideoAdNetworkAdapter.self]
    static func unregisterAllAdapterTypes() {
        //
    }
    static func unregister<T>(adapterType: T.Type) where T: VideoAdNetworkAdapter {
        //
    }
    static func register<T>(adapterType: T.Type) where T: VideoAdNetworkAdapter {
        testDelegate?.factoryRegisteredType = adapterType
    }
    func createAdapter(type: VideoAdNetworkSettings.NetworkType) -> VideoAdNetworkAdapter? {
        return MockFactory.testDelegate?.factoryCreateType.init(type: .test)
    }
}
