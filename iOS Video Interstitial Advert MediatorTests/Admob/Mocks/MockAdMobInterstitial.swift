//
//  MockAdMobInterstitial.swift
//  iOS Video Interstitial Advert MediatorTests
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import XCTest
import GoogleMobileAds
@testable import iOS_Video_Interstitial_Advert_Mediator

class MockAdMobInterstitial: AdMobAdProtocol {
    static weak var testDelegate: AdmobTestDelegate?
    weak var delegate: GADInterstitialDelegate? {
        didSet {
            MockAdMobInterstitial.testDelegate?.didSetDelegate = true
        }
    }
    required init(adUnitID: String) {
        //
    }
    func load(_ request: GADRequest?) {
        MockAdMobInterstitial.testDelegate?.loaded = true
    }
    func present(fromRootViewController rootViewController: UIViewController) {
        MockAdMobInterstitial.testDelegate?.presentedFrom = rootViewController
    }
}
