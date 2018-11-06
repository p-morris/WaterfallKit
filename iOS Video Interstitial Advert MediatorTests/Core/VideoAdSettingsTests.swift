//
//  VideoAdSettingsTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class VideoAdSettingsTests: XCTestCase {
    func testInitializationWithCustomFactoryClass() {
        let settings = VideoAdNetworkSettings(factoryType: MockFactory.self)
        XCTAssert(settings.factoryType == MockFactory.self,
                  "VideoAdNetworkSettings should initialize factoryType property.")
    }
}
