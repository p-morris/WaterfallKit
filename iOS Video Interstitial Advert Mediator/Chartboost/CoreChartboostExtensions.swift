//
//  CoreChartboostExtensions.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 05/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Adds support for the Chartboost video network to the `VideoAdNetworkSettings` class.
extension VideoAdNetworkSettings {
    /**
     Initializes the Chartboost ad network.
     
     - Parameters:
     - appID: Your Chartboost app ID.
     - appSignature: Your Chartboost app signature.
     - Returns: The VideoAdNetworkSettings object.
     */
    func initializeChartboost(appID: String, appSignature: String) -> Self {
        networkTypes.append(.chartboost(appID: appID, appSignature: appSignature))
        InterstitialAdapterFactory.register(adapterType: ChartboostAdapter.self)
        return self
    }
}
