//
//  AppLovinVideoAdNetwork.swift
//  iOS Video Interstitial Advert Mediator
//
//  Created by Peter Morris on 29/10/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation

/// Used for making interstitial video ad requests to the AdColony network
class AppLovinAdapter: NSObject, VideoAdNetworkAdapter {
    /// The object that acts as the delegate of the `AppLovinVideoAdNetwork`.
    weak var delegate: VideoAdNetworkAdapterDelegate?
    /// The priority of the network's ads for display purposes
    var priority = 0
    /// The AppLovin SDK key.
    let sdkKey: String
    /// The AppLovin SDK instance
    private let appLovin: ALSdk?
    /**
     Initializes a new `VideoAdNetworkAdapter` object.
     
     - Parameters:
     - type: The network type to use for instantiation.
     - Returns: An initialized `VideoAdNetworkAdapter` if `type` case is `.applovin`, nil otherwise.
     */
    required convenience init?(type: VideoAdNetworkSettings.NetworkType) {
        switch type {
        case let .appLovin(sdkKey): self.init(sdkKey: sdkKey)
        default: return nil
        }
    }
    /**
     Initializes a new `AppLovinVideoAdNetwork` object.
     
     - Parameters:
     - sdkKey: The AppLovin SDK key to use for ad requests.
     - Returns: An initialized `AppLovinVideoAdNetwork` object.
     */
    init(sdkKey: String) {
        self.sdkKey = sdkKey
        appLovin = ALSdk.shared(withKey: sdkKey)
    }
    /// Makes an interstitial video ad request using the AppLovin SDK.
    func requestAd() {
        appLovin?.adService.loadNextAd(.sizeInterstitial(), andNotify: self)
    }
    /**
     Compares `self` with `anotherAdNetwork`. `AppLovinVideoAdNetwork` objects are considered
     equal if they have an equal `sdkKey` property.
     - Parameters:
     - anotherAdNetwork: the `VideoAdNetwork` object to compare for equality.
     */
    func isEqual(to anotherAdNetwork: VideoAdNetworkAdapter) -> Bool {
        guard let anotherAdNetwork = anotherAdNetwork as? AppLovinAdapter else { return false }
        return sdkKey == anotherAdNetwork.sdkKey
    }
}

/// Used to implement delegate callbacks for AppLovin SDK ad loading events
extension AppLovinAdapter: ALAdLoadDelegate {
    func adService(_ adService: ALAdService, didLoad advert: ALAd) {
        if let appLovin = appLovin {
            let appLovinAd = AppLovinVideoAd(appLovinAd: advert, interstitial: ALInterstitialAd.init(sdk: appLovin))
            delegate?.adNetwork(self, didLoad: appLovinAd)
        }
    }
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        delegate?.adNetwork(self, didFailToLoad: NSError(domain: "AppLovinNoFill", code: Int(code), userInfo: nil))
    }
}