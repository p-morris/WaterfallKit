//
//  VideoAd.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

@objc enum AdNetwork: Int {
    case AdColony
    case AppLovin
    case Vungle
    case AdMob
    case Chartboost
    case TapJoy
    case IronSource
    case InMobi
    case Mopub
}

@objc protocol VideoAdDelegate {
    @objc optional func videoAdDidLoad(_ ad: VideoAd)
    @objc optional func videoAdDidFailToLoad(_ ad: VideoAd, error: Error?)
    @objc optional func videoAdDidAppear(_ ad: VideoAd)
    @objc optional func videoAdDidDismiss(_ ad: VideoAd)
    @objc optional func videoAdDidFailToPresent(_ ad: VideoAd)
    @objc optional func videoAdDidReceiveClick(_ ad: VideoAd)
}

@objc protocol VideoAd {
    var delegate: VideoAdDelegate? { get set }
    init(adNetwork: AdNetwork, delegate: VideoAdDelegate)
}
