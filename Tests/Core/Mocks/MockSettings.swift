//
//  MockSettings.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
//import WaterfallKit

extension VideoAdNetworkSettings {
    func removeAll() {
        networkTypes.removeAll()
    }
    func initializeForTest() {
        networkTypes.append(.test)
        factoryType.register(adapterType: MockVideoAdNetworkAdapter.self)
    }
    func addAnotherNetwork() {
        networkTypes.append(.test)
        factoryType.register(adapterType: AnotherMockVideoAdNetworkAdapter.self)
    }
}
