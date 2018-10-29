//
//  VideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used to instantiate `VideoAdNetwork` instances.
protocol VideoAdNetworkFactory {
    /**
     Instantiates and returns a concrete `VideoAdNetwork` object using the `NetworkType` it
     receives as an argument.
     
     - Parameters:
     - type: The `NetworkType` to instantiate a `VideoAdNetwork` object for
     - Returns: An object conforming to `VideoAdNetwork`.
     */
    func createAdNetwork(type: VideoAdNetworkSettings.NetworkType) -> VideoAdNetwork
}

extension VideoAdNetworkFactory {
    func createAdNetwork(type: VideoAdNetworkSettings.NetworkType) -> VideoAdNetwork {
        switch type {
        case let .adColony(appID, zoneIDs):
            return AdColonyVideoAdNetwork(appID: appID, zoneIDs: zoneIDs)
        case let .admob(appID, adUnitID):
            return AdMobVideoAdNetwork(appID: appID, adUnitID: adUnitID)
        case let .appLovin(sdkKey):
            return AppLovinVideoAdNetwork(sdkKey: sdkKey)
        case let .chartboost(appID, appSignature):
            return ChartboostVideoAdNetwork(appID: appID, appSignature: appSignature)
        case let .inMobi(accountID, gdprConsent):
            return InMobiVideoAdNetwork(accountID: accountID, gdprConsent: gdprConsent)
        case let .ironSource(appKey):
            return IronSourceVideoAdNetwork(appKey: appKey)
        case let .mopub(adUnitID):
            return MopubVideoAdNetwork(adUnitID: adUnitID)
        case let .vungle(appID, placementID):
            return VungleVideoAdNetwork(appID: appID, placementID: placementID)
        }
    }
}

/// Used to instantiate `VideoAdNetwork` instances for interstitatial video ads.
class InterstitialVideoAdNetworkFactory: VideoAdNetworkFactory { }

protocol VideoAdNetwork {
    /// The object that acts as the delegate of the `VideoAdNetwork`.
    var delegate: VideoAdNetworkDelegate? { get set }
    /**
     Sends a request to the ad network for a advert.
     */
    func requestAd()
}

/// Provides callbacks for AdNetwork request events.
protocol VideoAdNetworkDelegate: class {
    /**
     Executed when the ad network request is fulfilled.
     
     - Parameters:
     - adNetwork: The `VideoAdNetwork` responsible for the callback.
     - ad: A `VideoAd` object ready for display.
     */
    func adNetwork(_ adNetwork: VideoAdNetwork, didLoad advert: VideoAd)
    /**
     Executed when the ad network request either fails, or is unfulfilled.
     
     - Parameters:
     - adNetwork: The `VideoAdNetwork` responsible for the callback.
     - error: An `Error` representing the problem that occured.
     */
    func adNetwork(_ adNetwork: VideoAdNetwork, didFailToLoad error: Error)
}
