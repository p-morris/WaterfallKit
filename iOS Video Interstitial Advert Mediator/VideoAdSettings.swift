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
    private enum NetworkType {
        case adColony(appID: String, zoneIDs: [String])
        case appLovin(sdkKey: String)
        case vungle(appID: String, placementID: String)
        case admob(appID: String, adUnitID: String)
        case chartboost(appID: String, appSignature: String)
        case ironSource(appKey: String)
        case inMobi(accountID: String, gdprConsent: Bool)
        case mopub(adUnitID: String)
    }
    /// Contains all initialized settings
    private var settings: [NetworkType] = []
    /**
     Initializes the AdColony ad network.
     
     - Parameters:
     - appID: Your AdColony app ID.
     - zoneIDs: An array of `String` objects representing your AdColony zone IDs.
     */
    func initializeAdColony(appID: String, zoneIDs: [String]) -> Self {
        settings.append(.adColony(appID: appID, zoneIDs: zoneIDs))
        return self
    }
    /**
     Initializes the AppLovin ad network.
     
     - Parameters:
     - sdkKey: Your AppLovin sdk key.
     */
    func initializeAppLovin(sdkKey: String) -> Self {
        settings.append(.appLovin(sdkKey: sdkKey))
        return self
    }
    /**
     Initializes the Vungle ad network.
     
     - Parameters:
     - appID: Your Vungle app ID.
     - placementID: Your Vungle placement ID.
     */
    func initializeVungle(appID: String, placementID: String) -> Self {
        settings.append(.vungle(appID: appID, placementID: placementID))
        return self
    }
    /**
     Initializes the Admob ad network.
     
     - Parameters:
     - appID: Your Admob app ID.
     - adUnitID: Your Admob ad unit ID.
     */
    func initializeAdMob(appID: String, adUnitID: String) -> Self {
        settings.append(.admob(appID: appID, adUnitID: adUnitID))
        return self
    }
    /**
     Initializes the Chartboost ad network.
     
     - Parameters:
     - appID: Your Chartboost app ID.
     - appSignature: Your Chartboost app signature.
     */
    func initializeChartboost(appID: String, appSignature: String) -> Self {
        settings.append(.chartboost(appID: appID, appSignature: appSignature))
        return self
    }
    /**
     Initializes the IronSource ad network.
     
     - Parameters:
     - appKey: Your IronSource app key.
     */
    func initializeIronSource(appKey: String) -> Self {
        settings.append(.ironSource(appKey: appKey))
        return self
    }
    /**
     Initializes the InMobi ad network.
     
     - Parameters:
     - accountID: Your InMobi account ID.
     - gdprConsent: Pass `true` if you have user's consent to collect user data, `false` otherwise.
     */
    func initializeInMobi(accountID: String, gdprConsent: Bool) -> Self {
        settings.append(.inMobi(accountID: accountID, gdprConsent: gdprConsent))
        return self
    }
    /**
     Initializes the Mopub ad network.
     
     - Parameters:
     - adUnitID: Your Mopub add unit ID.
     */
    func initializeMoPub(adUnitID: String) -> Self {
        settings.append(.mopub(adUnitID: adUnitID))
        return self
    }
}
