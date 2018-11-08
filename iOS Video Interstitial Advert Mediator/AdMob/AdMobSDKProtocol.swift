//
//  AdMobSDKProtocol.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import GoogleMobileAds

protocol AdMobSDKProtocol {
    static func configure(withApplicationID applicationID: String)
}

extension GADMobileAds: AdMobSDKProtocol { }

protocol AdMobAdProtocol {
    var delegate: GADInterstitialDelegate? { get set }
    init(adUnitID: String)
    func load(_ request: GADRequest?)
}

extension GADInterstitial: AdMobAdProtocol { }
