//
//  CoreAdColonyExtensions.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 05/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Adds support for the AdColony video network to the `VideoAdNetworkSettings` class.
extension VideoAdNetworkSettings {
    /**
     Initializes the AdColony ad network.
     
     - Parameters:
     - appID: Your AdColony app ID.
     - zoneIDs: An array of `String` objects representing your AdColony zone IDs.
     - Returns: The VideoAdNetworkSettings object.
     */
    public func initializeAdColony(appID: String, zoneID: String) -> Self {
        networkTypes.append(.adColony(appID: appID, zoneID: zoneID))
        factoryType.register(adapterType: AdColonyAdapter.self)
        return self
    }
}
