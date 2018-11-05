//
//  CoreAppLovinExtensions.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 05/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Adds support for the AppLovin video network to the `VideoAdNetworkSettings` class.
extension VideoAdNetworkSettings {
    /**
     Initializes the AppLovin ad network.
     
     - Parameter sdkKey: Your AppLovin sdk key.
     - Returns: The VideoAdNetworkSettings object.
     */
    func initializeAppLovin(sdkKey: String) -> Self {
        networkTypes.append(.appLovin(sdkKey: sdkKey))
        InterstitialAdapterFactory.register(adapterType: AppLovinAdapter.self)
        return self
    }
}
