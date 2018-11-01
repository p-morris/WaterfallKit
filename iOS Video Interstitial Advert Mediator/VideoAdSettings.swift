//
//  VideoAdSettings.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/**
Settings object which holds client's account details for all ad networks. Provides
 public initialization method for each supported ad network. Each initialization method
 returns the instance, so they can be chained.
 
 The order in which networks are initialized defines their priority. Ads of a higher priority
 will always be favoured for display over ads of a lower priority.
 
 ## Example
 ```
 let adSettings = VideoAdNetworkSettings()
    .initializeAdColony(appID: "{app-id-here", zoneIDs: ["zone-id-here"]
    .initializeAppLovin(sdkKey: "sdk-key-here")
    .initializeVungle(appID: "app-id-here", placementID: "placement-id-here"
 ```
 
 In the above example, the ad priority order will be:

 1) AdColony
 2) AppLovin
 3) Vungle
 
 */
@objc final class VideoAdNetworkSettings: NSObject {
    /// Encapsulates the required account details for each ad network
    enum NetworkType {
        case adColony(appID: String, zoneID: String)
        case appLovin(sdkKey: String)
        case vungle(appID: String, placementID: String)
        case admob(appID: String, adUnitID: String)
        case chartboost(appID: String, appSignature: String)
    }
    /// Contains all initialized ad network settings. Order determines ad priority.
    private (set) var networkTypes: [NetworkType] = []
    /**
     Initializes the AdColony ad network.
     
     - Parameters:
     - appID: Your AdColony app ID.
     - zoneIDs: An array of `String` objects representing your AdColony zone IDs.
     - Returns: The VideoAdNetworkSettings object.
     */
    func initializeAdColony(appID: String, zoneID: String) -> Self {
        networkTypes.append(.adColony(appID: appID, zoneID: zoneID))
        return self
    }
    /**
     Initializes the AppLovin ad network.
     
     - Parameter sdkKey: Your AppLovin sdk key.
     - Returns: The VideoAdNetworkSettings object.
     */
    func initializeAppLovin(sdkKey: String) -> Self {
        networkTypes.append(.appLovin(sdkKey: sdkKey))
        return self
    }
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
    /**
     Initializes the Admob ad network.
     
     - Parameters:
     - appID: Your Admob app ID.
     - adUnitID: Your Admob ad unit ID.
     - Returns: The VideoAdNetworkSettings object.
     */
    func initializeAdMob(appID: String, adUnitID: String) -> Self {
        networkTypes.append(.admob(appID: appID, adUnitID: adUnitID))
        return self
    }
    /**
     Initializes the Chartboost ad network.
     
     - Parameters:
     - appID: Your Chartboost app ID.
     - appSignature: Your Chartboost app signature.
     - Returns: The VideoAdNetworkSettings object.
     */
    func initializeChartboost(appID: String, appSignature: String) -> Self {
        networkTypes.append(.chartboost(appID: appID, appSignature: appSignature))
        return self
    }
}
