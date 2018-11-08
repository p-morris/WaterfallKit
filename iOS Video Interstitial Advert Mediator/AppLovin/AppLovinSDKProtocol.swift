//
//  AppLovinSDKProtocol.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 08/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

protocol AppLovinSDKProtocol {
    static func shared(withKey sdkKey: String) -> ALSdk?
    var adService: ALAdService { get }
}

extension ALSdk: AppLovinSDKProtocol { }

protocol AppLovinInterstitialProtocol {
    var adDisplayDelegate: ALAdDisplayDelegate? { get set }
    func showOver(_ window: UIWindow, andRender advert: ALAd)
}

extension ALInterstitialAd: AppLovinInterstitialProtocol { }
