//
//  CoreAdMobExtensions.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 05/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Adds support for the Admob video network to the `VideoAdNetworkSettings` class.
extension VideoAdNetworkSettings {
    /**
     Initializes the Admob ad network.
     
     - Parameters:
     - appID: Your Admob app ID.
     - adUnitID: Your Admob ad unit ID.
     - Returns: The VideoAdNetworkSettings object.
     */
    func initializeAdMob(appID: String, adUnitID: String) -> Self {
        networkTypes.append(.admob(appID: appID, adUnitID: adUnitID))
        factoryType.register(adapterType: AdMobAdapter.self)
        return self
    }
}
