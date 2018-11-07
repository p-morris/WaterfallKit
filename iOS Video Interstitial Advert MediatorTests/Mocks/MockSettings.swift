//
//  MockSettings.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

extension VideoAdNetworkSettings {
    func initializeForTest() {
        networkTypes.append(.test)
        factoryType.register(adapterType: MockVideoAdNetworkAdapter.self)
    }
    func addAnotherNetwork() {
        networkTypes.append(.test)
        factoryType.register(adapterType: AnotherMockVideoAdNetworkAdapter.self)
    }
}
