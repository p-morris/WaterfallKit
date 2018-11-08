//
//  MockAppLovinInterstitial.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
@testable import iOS_Video_Interstitial_Advert_Mediator

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
