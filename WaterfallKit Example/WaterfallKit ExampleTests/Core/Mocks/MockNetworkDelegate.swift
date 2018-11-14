//
//  MockNetworkDelegate.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 06/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import WaterfallKit

class MockNetworkDelegate: VideoAdNetworkAdapterDelegate {
    var didLoad = false
    var error: Error?
    func adNetwork(_ adapter: VideoAdNetworkAdapter, didLoad advert: VideoAd) {
        didLoad = true
    }
    func adNetwork(_ adapter: VideoAdNetworkAdapter, didFailToLoad error: Error) {
        self.error = error
    }
}
