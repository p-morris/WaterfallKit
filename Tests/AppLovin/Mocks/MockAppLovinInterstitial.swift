//
//  MockAppLovinInterstitial.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
import AppLovinSDK
//import WaterfallKit

class MockAppLovinInterstitial: AppLovinInterstitialProtocol {
    var didSetDelegate: Bool {
        return adDisplayDelegate != nil
    }
    var didShow = false
    weak var adDisplayDelegate: ALAdDisplayDelegate?
    func showOver(_ window: UIWindow, andRender advert: ALAd) {
        self.didShow = true
    }
}
