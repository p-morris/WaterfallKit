//
//  VideoAdNetworkAdapterFactory.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 02/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used to instantiate `VideoAdNetwork` instances.
protocol VideoAdNetworkAdapterFactory {
    /**
     Instantiates and returns a concrete `VideoAdNetwork` object using the `NetworkType` it
     receives as an argument.
     
     - Parameters:
     - type: The `NetworkType` to instantiate a `VideoAdNetwork` object for
     - Returns: An object conforming to `VideoAdNetwork`.
     */
    func createAdapter(type: VideoAdNetworkSettings.NetworkType) -> VideoAdNetworkAdapter
}

extension VideoAdNetworkAdapterFactory {
    func createAdapter(type: VideoAdNetworkSettings.NetworkType) -> VideoAdNetworkAdapter {
        switch type {
        case let .adColony(appID, zoneID):
            return AdColonyAdapter(appID: appID, zoneID: zoneID)
        case let .admob(appID, adUnitID):
            return AdMobAdapter(appID: appID, adUnitID: adUnitID)
        case let .appLovin(sdkKey):
            return AppLovinAdapter(sdkKey: sdkKey)
        case let .chartboost(appID, appSignature):
            return ChartboostAdapter(appID: appID, appSignature: appSignature)
        case let .vungle(appID, placementID):
            return VungleAdapter(appID: appID, placementID: placementID)
        }
    }
}

/// Used to instantiate `VideoAdNetwork` instances for interstitatial video ads.
class InterstitialAdapterFactory: VideoAdNetworkAdapterFactory { }
