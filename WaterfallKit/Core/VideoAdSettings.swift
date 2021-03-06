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
@objc public final class VideoAdNetworkSettings: NSObject {
    /// The factory type to be used
    public let factoryType: VideoAdNetworkAdapterFactory.Type
    /// Encapsulates the required account details for each ad network
    public enum NetworkType {
        case adColony(appID: String, zoneID: String)
        case appLovin(sdkKey: String)
        case vungle(appID: String, placementID: String)
        case admob(appID: String, adUnitID: String)
        case chartboost(appID: String, appSignature: String)
        case test
        // A String represnting the name of the ad network.
        public var name: String {
            switch self {
            case .adColony: return "AdColony"
            case .appLovin: return "AppLovin"
            case .vungle: return "Vungle"
            case .admob: return "Admob"
            case .chartboost: return "Chartboost"
            case .test: return "Test"
            }
        }
    }
    /// Contains all initialized ad network settings. Order determines ad priority.
    public var networkTypes: [NetworkType] = []
    /**
     Initializes a new `VideoAdNetworkSettings` object.
     
     - Parameters:
     - factoryType: The factory type to use for registering adapter classes.
     - Returns: An initialized `VideoAdNetworkSettings` object.
     */
    public init(factoryType: VideoAdNetworkAdapterFactory.Type = InterstitialAdapterFactory.self) {
        self.factoryType = factoryType
    }
}
