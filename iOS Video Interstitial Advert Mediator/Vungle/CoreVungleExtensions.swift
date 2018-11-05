//
//  CoreVungleExtensions.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 05/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Adds support for the Vungle video network to the `VideoAdNetworkSettings` class.
extension VideoAdNetworkSettings {
    /**
     Initializes the Vungle ad network.
     
     - Parameters:
     - appID: Your Vungle app ID.
     - placementID: Your Vungle placement ID.
     - Returns: The VideoAdNetworkSettings object.
     */
    func initializeVungle(appID: String, placementID: String) -> Self {
        networkTypes.append(.vungle(appID: appID, placementID: placementID))
        return self
    }
}
