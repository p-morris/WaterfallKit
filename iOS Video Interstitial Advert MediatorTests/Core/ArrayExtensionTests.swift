//
//  ArrayExtensionTests.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

class ArrayExtensionTests: XCTestCase {
    func testRemoveNetwork() {
        let network1 = MockTimeOutableNetwork(type: .appLovin(sdkKey: ""))!
        let array = [network1].removing(adapter: network1)
        XCTAssertEqual(array.count, 0, "[VideoAdNetworkAdapter] removing should remove specified ad network.")
    }
}
